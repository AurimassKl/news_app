import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_articles/news_articles_data_source.dart';
import 'package:newsapp/data/data_source/news_source/news_source_data_source.dart';
import 'package:newsapp/data/models/news_article/news_article_model.dart';
import 'package:newsapp/data/models/news_response/news_response_model.dart';
import 'package:newsapp/data/models/news_source/news_source_model.dart';
import 'package:newsapp/data/models/news_source_responce/news_source_response_model.dart';
import 'package:newsapp/data/repositories/news_article_repository_impl.dart';
import 'package:newsapp/data/repositories/news_source_repository_impl.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/domain/entities/news_sources.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';
import 'package:newsapp/domain/repositories/news_sources_repository.dart';

import 'news_source_repository_impl_test.mocks.dart';

Result<NewsSourceResponseModel> _dummyResult() => Success<NewsSourceResponseModel>(
      data: NewsSourceResponseModel(
        status: "ok",
        totalResults: 0,
        sources: [],
      ),
    );

@GenerateMocks([NewsSourcesDataSource])
void main() {
  late MockNewsSourcesDataSource mockDataSource;
  late NewsSourcesRepository repository;

  setUp(() {
    provideDummy<Result<NewsSourceResponseModel>>(_dummyResult());
    mockDataSource = MockNewsSourcesDataSource();
    repository = NewsSourcesRepositoryImpl(mockDataSource);
  });

  final testFilter = NewsSourceFilter(country: "us");

  test('get news sources success', () async {
    final responseModel = NewsSourceResponseModel(
      status: "ok",
      totalResults: 2,
      sources: [
        NewsSourceModel(
          id: "id1",
          name: "name1",
          description: "description",
          url: "url",
          category: "category",
          language: "language",
          country: "country",
        ),
        NewsSourceModel(
          id: "id2",
          name: "name2",
          description: "description",
          url: "url",
          category: "category",
          language: "language",
          country: "country",
        ),
      ],
    );

    when(mockDataSource.getNewsSources(testFilter)).thenAnswer(
      (_) async => Success(data: responseModel),
    );

    final result = await repository.getNewsSources(testFilter);

    expect(result, isA<Success>());
    final sources = (result as Success).data;
    expect(sources, isA<List<NewsSource>>());
    expect(sources.length, 2);
    expect(sources[0].name, "name1");
    expect(sources[1].name, "name2");
  });

  test('get news sources failure', () async {
    when(mockDataSource.getNewsSources(testFilter)).thenAnswer(
      (_) async => Failure(message: "Error"),
    );

    final result = await repository.getNewsSources(testFilter);

    expect(result, isA<Failure>());
    expect((result as Failure).message, "Error");
  });
}
