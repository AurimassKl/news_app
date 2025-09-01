import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/use_cases/get_news_articles.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_state.dart';

import 'news_articles_bloc_test.mocks.dart';

Result<List<NewsArticle>> _dummyResult() => Success<List<NewsArticle>>(
      data: [],
    );

@GenerateMocks([GetNewsArticles])
void main() {
  late MockGetNewsArticles mockUseCase;
  late NewsArticlesBloc bloc;

  final testFilter = const NewsFilter(country: "us");

  final testArticles = [
    NewsArticle(
      title: "title1",
      url: "url1",
      sourceName: "sourceName1",
      sourceId: "sourceId1",
      author: "author1",
      description: "description1",
      urlToImage: "urlToImage1",
      publishedAt: "publishedAt1",
      content: "content1",
    ),
    NewsArticle(
      title: "title2",
      url: "url2",
      sourceName: "sourceName2",
      sourceId: "sourceId2",
      author: "author2",
      description: "description2",
      urlToImage: "urlToImage2",
      publishedAt: "publishedAt2",
      content: "content2",
    ),
  ];

  setUp(() {
    provideDummy<Result<List<NewsArticle>>>(_dummyResult());
    mockUseCase = MockGetNewsArticles();
    bloc = NewsArticlesBloc(mockUseCase);
  });

  test('initial state is NewsArticlesUninitializedState', () {
    expect(bloc.state, isA<NewsArticlesUninitializedState>());
  });

  blocTest<NewsArticlesBloc, NewsArticlesState>(
    'emits [Fetching, Fetched] when FetchNewsArticles succeeds',
    build: () {
      when(mockUseCase(any)).thenAnswer(
        (_) async => Success(data: testArticles),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(FetchNewsArticles(testFilter)),
    expect: () => [
      isA<NewsArticlesFetchingState>(),
      isA<NewsArticlesFetchedState>().having((s) => s.newsArticles.length, 'length', 2),
    ],
  );

  blocTest<NewsArticlesBloc, NewsArticlesState>(
    'emits [Fetching, Error] when FetchNewsArticles fails',
    build: () {
      when(mockUseCase(any)).thenAnswer(
        (_) async => Failure(message: "Error"),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(FetchNewsArticles(testFilter)),
    expect: () => [
      isA<NewsArticlesFetchingState>(),
      isA<NewsArticlesErrorState>().having((s) => s.message, 'message', "Error"),
    ],
  );

  blocTest<NewsArticlesBloc, NewsArticlesState>(
    'emits [Fetched with more articles] when FetchMoreNewsArticles succeeds',
    build: () {
      when(mockUseCase(any)).thenAnswer(
        (_) async => Success(data: testArticles),
      );
      return bloc;
    },
    act: (bloc) async {
      bloc.add(FetchNewsArticles(testFilter));
      await untilCalled(mockUseCase(any));
      when(mockUseCase(any)).thenAnswer(
        (_) async => Success(
          data: [
            NewsArticle(
              title: "title3",
              url: "url3",
              sourceName: "sourceName3",
              sourceId: "sourceId3",
              author: "author3",
              description: "description3",
              urlToImage: "urlToImage3",
              publishedAt: "publishedAt3",
              content: "content3",
            ),
          ],
        ),
      );
      bloc.add(FetchMoreNewsArticles());
    },
    expect: () => [
      isA<NewsArticlesFetchingState>(),
      isA<NewsArticlesFetchedState>().having((s) => s.newsArticles.length, 'length', 2),
      isA<NewsArticlesFetchedState>().having((s) => s.newsArticles.length, 'length', 2),
      isA<NewsArticlesFetchedState>().having((s) => s.newsArticles.length, 'length', 3),
    ],
  );

  blocTest<NewsArticlesBloc, NewsArticlesState>(
    'keeps old state when FetchMoreNewsArticles fails',
    build: () {
      when(mockUseCase(any)).thenAnswer(
        (_) async => Success(data: testArticles),
      );
      return bloc;
    },
    act: (bloc) async {
      bloc.add(FetchNewsArticles(testFilter));
      await untilCalled(mockUseCase(any));
      when(mockUseCase(any)).thenAnswer(
        (_) async => Failure(message: "Error"),
      );
      bloc.add(FetchMoreNewsArticles());
    },
    expect: () => [
      isA<NewsArticlesFetchingState>(),
      isA<NewsArticlesFetchedState>().having((s) => s.newsArticles.length, 'length', 2),
      isA<NewsArticlesFetchedState>().having((s) => s.isLoadingMore, 'isLoadingMore', true),
      isA<NewsArticlesFetchedState>().having((s) => s.isLoadingMore, 'isLoadingMore', false),
    ],
  );
}
