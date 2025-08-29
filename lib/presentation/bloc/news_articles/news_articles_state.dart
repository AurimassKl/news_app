import 'package:newsapp/domain/entities/news_article.dart';

abstract class NewsArticlesState {}

class NewsArticlesUninitializedState extends NewsArticlesState {}

class NewsArticlesFetchingState extends NewsArticlesState {}

class NewsArticlesFetchedState extends NewsArticlesState {
  final List<NewsArticle> newsArticles;

  NewsArticlesFetchedState(this.newsArticles);
}

class NewsArticlesErrorState extends NewsArticlesState {
  final String message;

  NewsArticlesErrorState(this.message);
}
