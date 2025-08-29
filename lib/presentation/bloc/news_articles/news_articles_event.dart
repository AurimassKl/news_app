import 'package:newsapp/domain/entities/news_filter.dart';

sealed class NewsArticlesEvent {
  const NewsArticlesEvent();
}

class FetchNewsArticles extends NewsArticlesEvent {
  final NewsFilter filter;
  FetchNewsArticles(this.filter);
}
