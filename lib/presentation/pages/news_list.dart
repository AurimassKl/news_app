import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/core/colors.dart';
import 'package:newsapp/core/utils/time_formater.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_state.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_bloc.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_event.dart';
import 'package:newsapp/presentation/pages/widgets/news_filter.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsArticlesBloc>().add(FetchNewsArticles(NewsFilter(country: "us")));
    context.read<NewsSourcesBloc>().add(FetchNewsSources(NewsSourceFilter(country: "us")));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Center(
          child: Text(
            'News Articles',
            style: TextStyle(
              fontSize: SizeConfig.screenWidth * 0.1,
              fontWeight: FontWeight.w900,
              foreground: Paint()..shader = kAppBarTextColor,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          NewsFilterBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
              child: BlocBuilder<NewsArticlesBloc, NewsArticlesState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: () {
                      if (state is NewsArticlesFetchingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is NewsArticlesErrorState) {
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Text(
                              state.message,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.screenWidth * 0.04,
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is NewsArticlesFetchedState) {
                        return _NewsList(state);
                      }
                      return const SizedBox.shrink();
                    }(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    final bloc = context.read<NewsArticlesBloc>();
    bloc.add(FetchNewsArticles(bloc.currentFilter));
    await Future.delayed(const Duration(milliseconds: 300));
  }
}

class _NewsList extends StatefulWidget {
  final NewsArticlesFetchedState state;

  const _NewsList(this.state, {super.key});

  @override
  State<_NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<_NewsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final items = widget.state.newsArticles;
    final showFooterLoader = widget.state.isLoadingMore;

    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: items.length + (showFooterLoader ? 1 : 0),
      itemBuilder: (context, index) {
        if (showFooterLoader && index == items.length) {
          return Center(child: CircularProgressIndicator());
        }

        final article = items[index];

        return Card(
          color: kNewsCardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _openArticle(article),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.screenWidth * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/default_news.png',
                      image: article.urlToImage.isNotEmpty == true ? article.urlToImage : '',
                      width: double.infinity,
                      height: SizeConfig.screenHeight * 0.22,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_news.png',
                          width: double.infinity,
                          height: SizeConfig.screenHeight * 0.22,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    article.description,
                    style: TextStyle(
                      fontSize: SizeConfig.screenWidth * 0.032,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      timeToReadableFormat(article.publishedAt),
                      style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onScroll() {
    final bloc = context.read<NewsArticlesBloc>();
    final state = bloc.state;
    if (state is! NewsArticlesFetchedState) return;

    final nearBottom = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200;

    if (nearBottom && state.hasMore && !state.isLoadingMore) {
      bloc.add(FetchMoreNewsArticles());
    }
  }

  void _openArticle(NewsArticle article) {}
}
