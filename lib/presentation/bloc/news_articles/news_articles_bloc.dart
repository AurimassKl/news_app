import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/use_cases/get_news_articles.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_state.dart';

class NewsArticlesBloc extends Bloc<NewsArticlesEvent, NewsArticlesState> {
  final GetNewsArticles _useCase;

  NewsFilter _currentFilter = const NewsFilter(country: "us");

  NewsFilter get currentFilter => _currentFilter;

  NewsArticlesBloc(this._useCase) : super(NewsArticlesUninitializedState()) {
    on<FetchNewsArticles>(
      (event, emit) async {
        _currentFilter = event.filter.copyWith(
          country: event.filter.country ?? _currentFilter.country,
          category: event.filter.category ?? _currentFilter.category,
          sources: event.filter.sources ?? _currentFilter.sources,
          query: event.filter.query ?? _currentFilter.query,
        );

        emit(NewsArticlesFetchingState());

        final response = await _useCase(_currentFilter);

        switch (response) {
          case Success(:final data):
            emit(NewsArticlesFetchedState(data));
          case Failure(:final message):
            emit(NewsArticlesErrorState(message));
        }
      },
    );
  }
}
