import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/use_cases/get_news_articles.dart';
import 'package:newsapp/presentation/bloc/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles_state.dart';

class NewsArticlesBloc extends Bloc<NewsArticlesEvent, NewsArticlesState> {
  final GetNewsArticles _useCase;

  NewsArticlesBloc(this._useCase) : super(NewsArticlesUninitializedState()) {
    on<NewsArticlesEvent>((event, emit) async {
      emit(NewsArticlesFetchingState());
      final response = await _useCase();
      switch (response) {
        case Success(:final data):
          emit(NewsArticlesFetchedState(data));
        case Failure(:final message):
          emit(NewsArticlesErrorState(message));
      }
    });
  }
}
