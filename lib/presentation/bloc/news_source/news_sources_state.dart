import 'package:newsapp/domain/entities/news_sources.dart';

abstract class NewsSourcesState {}

class NewsSourcesUninitializedState extends NewsSourcesState {}

class NewsSourcesFetchingState extends NewsSourcesState {}

class NewsSourcesFetchedState extends NewsSourcesState {
  final List<NewsSource> newsSources;

  NewsSourcesFetchedState(this.newsSources);
}

class NewsSourcesErrorState extends NewsSourcesState {
  final String message;

  NewsSourcesErrorState(this.message);
}
