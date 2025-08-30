import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/use_cases/get_news_articles.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_state.dart';

class NewsArticlesBloc extends Bloc<NewsArticlesEvent, NewsArticlesState> {
  final GetNewsArticles _useCase;

  NewsFilter _currentFilter = const NewsFilter(country: "us");
  List<NewsArticle> _articles = [];

  NewsFilter get currentFilter => _currentFilter;

  NewsArticlesBloc(this._useCase) : super(NewsArticlesUninitializedState()) {
    on<FetchNewsArticles>(_onFetchNewsArticles);
    on<FetchMoreNewsArticles>(_onFetchMoreNewsArticles);
  }

  Future<void> _onFetchNewsArticles(FetchNewsArticles event, Emitter<NewsArticlesState> emit) async {
    _currentFilter = _currentFilter.copyWith(
      country: event.filter.country ?? _currentFilter.country,
      category: event.filter.category ?? _currentFilter.category,
      sources: event.filter.sources ?? _currentFilter.sources,
      query: event.filter.query ?? _currentFilter.query,
      page: 1,
    );

    _articles = [];
    emit(NewsArticlesFetchingState());

    final response = await _useCase(_currentFilter);
    switch (response) {
      case Success(:final data):
        _articles = data;
        final hasMore = _articles.isNotEmpty;
        emit(NewsArticlesFetchedState(_articles, hasMore: hasMore));
      case Failure(:final message):
        print("---");
        emit(NewsArticlesErrorState(message));
    }
  }

  Future<void> _onFetchMoreNewsArticles(FetchMoreNewsArticles event, Emitter<NewsArticlesState> emit) async {
    final currentState = state;
    if (currentState is! NewsArticlesFetchedState) return;

    if (currentState.isLoadingMore || !currentState.hasMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final nextFilter = _currentFilter.copyWith(page: _currentFilter.page + 1);

    final response = await _useCase(nextFilter);
    switch (response) {
      case Success(:final data):
        _currentFilter = nextFilter;
        _articles = [..._articles, ...data];
        final hasMore = data.isNotEmpty;
        emit(NewsArticlesFetchedState(_articles, isLoadingMore: false, hasMore: hasMore));
      case Failure(:final message):
        emit(currentState.copyWith(isLoadingMore: false));
    }
  }
}
