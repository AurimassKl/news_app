import 'package:newsapp/domain/entities/news_article.dart';

abstract class NewsArticlesState {}

class NewsArticlesUninitializedState extends NewsArticlesState {}

class NewsArticlesFetchingState extends NewsArticlesState {}

class NewsArticlesFetchedState extends NewsArticlesState {
  final List<NewsArticle> newsArticles;
  final bool isLoadingMore;
  final bool hasMore;

  NewsArticlesFetchedState(
    this.newsArticles, {
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  NewsArticlesFetchedState copyWith({
    List<NewsArticle>? newsArticles,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return NewsArticlesFetchedState(
      newsArticles ?? this.newsArticles,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class NewsArticlesErrorState extends NewsArticlesState {
  final String message;

  NewsArticlesErrorState(this.message);
}
