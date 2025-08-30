import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/core/colors.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_state.dart';
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
    // context.read<NewsArticlesBloc>().add(FetchNewsArticles(NewsFilter(country: "us")));
    // context.read<NewsSourcesBloc>().add(FetchNewsSources(NewsSourceFilter(country: "us")));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Top headlines',
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
            child: BlocBuilder<NewsArticlesBloc, NewsArticlesState>(builder: (context, state) {
              if (state is NewsArticlesFetchingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is NewsArticlesErrorState) {
                return const Center(
                  child: Text("Error"),
                );
              }
              if (state is NewsArticlesFetchedState) {
                return _NewsList(state);
              }
              return const SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
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

  void _onScroll() {
    final bloc = context.read<NewsArticlesBloc>();
    final state = bloc.state;
    if (state is! NewsArticlesFetchedState) return;

    final nearBottom = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200;

    if (nearBottom && state.hasMore && !state.isLoadingMore) {
      bloc.add(FetchMoreNewsArticles());
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.state.newsArticles;
    final showFooterLoader = widget.state.isLoadingMore;

    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length + (showFooterLoader ? 1 : 0),
        itemBuilder: (context, index) {
          if (showFooterLoader && index == items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final article = items[index];
          return ListTile(
            // leading: article.urlToImage != ""
            //     ? Image.network(article.urlToImage.toString(), width: 60, fit: BoxFit.cover)
            //     : const Icon(Icons.article_outlined),
            leading: Text(index.toString()),
            title: Text(article.title),

            subtitle: Text(article.sourceName ?? ''),
            onTap: () => _openArticle(context, article),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    final bloc = context.read<NewsArticlesBloc>();
    bloc.add(FetchNewsArticles(bloc.currentFilter));
    await Future.delayed(const Duration(milliseconds: 300));
  }

  void _openArticle(BuildContext context, NewsArticle article) {}
}
