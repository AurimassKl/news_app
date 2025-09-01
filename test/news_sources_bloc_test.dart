import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/domain/entities/news_sources.dart';
import 'package:newsapp/domain/use_cases/get_news_sources_article.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_bloc.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_event.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_state.dart';

import 'news_sources_bloc_test.mocks.dart';

Result<List<NewsSource>> _dummyResult() => Success<List<NewsSource>>(
      data: [],
    );

@GenerateMocks([GetNewsSources])
void main() {
  late MockGetNewsSources mockUseCase;
  late NewsSourcesBloc bloc;

  final testFilter = const NewsSourceFilter(country: "us");

  final testSources = [
    NewsSource(
      id: "id1",
      url: "url1",
      name: "name1",
      category: "category1",
      language: "language1",
      country: "country1",
      description: "description1",
    ),
    NewsSource(
      id: "id2",
      url: "url2",
      name: "name2",
      category: "category2",
      language: "language2",
      country: "country2",
      description: "description2",
    ),
  ];

  setUp(() {
    provideDummy<Result<List<NewsSource>>>(_dummyResult());
    mockUseCase = MockGetNewsSources();
    bloc = NewsSourcesBloc(mockUseCase);
  });

  test('initial state is NewsSourcesUninitializedState', () {
    expect(bloc.state, isA<NewsSourcesUninitializedState>());
  });

  blocTest<NewsSourcesBloc, NewsSourcesState>(
    'emits [Fetching, Fetched] when FetchNewsSources succeeds',
    build: () {
      when(mockUseCase(any)).thenAnswer(
        (_) async => Success(data: testSources),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(FetchNewsSources(testFilter)),
    expect: () => [
      isA<NewsSourcesFetchingState>(),
      isA<NewsSourcesFetchedState>().having((s) => s.newsSources.length, 'length', 2),
    ],
  );

  blocTest<NewsSourcesBloc, NewsSourcesState>(
    'emits [Fetching, Error] when FetchNewsSources fails',
    build: () {
      when(mockUseCase(any)).thenAnswer(
        (_) async => Failure(message: "Error"),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(FetchNewsSources(testFilter)),
    expect: () => [
      isA<NewsSourcesFetchingState>(),
      isA<NewsSourcesErrorState>().having((s) => s.message, 'message', "Error"),
    ],
  );
}
