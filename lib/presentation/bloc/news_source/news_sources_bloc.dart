import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/domain/use_cases/get_news_sources_article.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_event.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_state.dart';

class NewsSourcesBloc extends Bloc<NewsSourcesEvent, NewsSourcesState> {
  final GetNewsSources _useCase;

  NewsSourceFilter _currentFilter = NewsSourceFilter();

  NewsSourceFilter get currentFilter => _currentFilter;

  NewsSourcesBloc(this._useCase) : super(NewsSourcesUninitializedState()) {
    on<FetchNewsSources>(
      (event, emit) async {
        _currentFilter = event.filter.copyWith(
          country: event.filter.country ?? _currentFilter.country,
          category: event.filter.category ?? _currentFilter.category,
        );

        emit(NewsSourcesFetchingState());

        final response = await _useCase(_currentFilter);

        switch (response) {
          case Success(:final data):
            emit(NewsSourcesFetchedState(data));
          case Failure(:final message):
            emit(NewsSourcesErrorState(message));
        }
      },
    );
  }
}
