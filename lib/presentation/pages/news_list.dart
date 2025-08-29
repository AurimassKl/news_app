import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/core/colors.dart';
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
                return _NewsList(state.newsArticles);
              }
              return const SizedBox.shrink();
            }),
          ),
        ],
      ),
    );
  }
}

class _NewsList extends StatelessWidget {
  final List<NewsArticle> newsArticles;

  const _NewsList(this.newsArticles, {super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: ListView.separated(
        itemBuilder: (_, i) {
          final article = newsArticles[i];
          return ListTile(
            leading: article.urlToImage != ""
                ? Image.network(article.urlToImage.toString(), width: 60, fit: BoxFit.cover)
                : const Icon(Icons.article_outlined),
            title: Text(article.title),
            subtitle: Text(article.sourceName ?? ''),
            onTap: () => _openArticle(context, article),
          );
        },
        separatorBuilder: (_, __) => const Divider(
          height: 1,
        ),
        itemCount: newsArticles.length,
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) {
    final bloc = context.read<NewsArticlesBloc>();
    bloc.add(FetchNewsArticles(bloc.currentFilter));
    return Future.delayed(const Duration(milliseconds: 300));
  }

  void _openArticle(BuildContext context, NewsArticle article) {}
}
