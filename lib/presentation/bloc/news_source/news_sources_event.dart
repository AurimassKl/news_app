import 'package:newsapp/domain/entities/news_source_filter.dart';

sealed class NewsSourcesEvent {
  const NewsSourcesEvent();
}

class FetchNewsSources extends NewsSourcesEvent {
  final NewsSourceFilter filter;
  FetchNewsSources(this.filter);
}
