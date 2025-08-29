import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/presentation/bloc/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles_state.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsArticlesBloc>().add(NewsArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top headlines',
        ),
      ),
      body: BlocBuilder<NewsArticlesBloc, NewsArticlesState>(builder: (context, state) {
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
    );
  }
}

class _NewsList extends StatelessWidget {
  final List<NewsArticle> newsArticles;

  const _NewsList(this.newsArticles, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) {
        final article = newsArticles[i];
        return ListTile(
          leading: article.urlToImage != ""
              ? Image.network(article.urlToImage.toString(), width: 60, fit: BoxFit.cover)
              : const Icon(Icons.article_outlined),
          title: Text(article.title),
          subtitle: Text(article.sourceName ?? ''),
          onTap: () => _openArticle(context, article.url),
        );
      },
      separatorBuilder: (_, __) => const Divider(
        height: 1,
      ),
      itemCount: newsArticles.length,
    );
  }

  void _openArticle(BuildContext context, String url) {}
}
