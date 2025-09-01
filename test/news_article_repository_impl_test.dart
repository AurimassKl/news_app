import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_articles/news_articles_data_source.dart';
import 'package:newsapp/data/models/news_article/news_article_model.dart';
import 'package:newsapp/data/models/news_response/news_response_model.dart';
import 'package:newsapp/data/repositories/news_article_repository_impl.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';

import 'news_article_repository_impl_test.mocks.dart';

Result<NewsResponseModel> _dummyResult() => Success<NewsResponseModel>(
      data: NewsResponseModel(
        status: "ok",
        totalResults: 0,
        articles: [],
      ),
    );

@GenerateMocks([NewsArticlesDataSource])
void main() {
  late MockNewsArticlesDataSource mockDataSource;
  late NewsArticlesRepository repository;

  setUp(() {
    provideDummy<Result<NewsResponseModel>>(_dummyResult());
    mockDataSource = MockNewsArticlesDataSource();
    repository = NewsArticlesRepositoryImpl(mockDataSource);
  });

  final testFilter = NewsFilter(country: "us");

  test('get news articles success', () async {
    final responseModel = NewsResponseModel(
      status: "ok",
      totalResults: 2,
      articles: [
        NewsArticleModel(
          title: "title1",
          urlToImage: "urlToImage",
          description: "description",
          publishedAt: "publishedAt",
          source: SourceModel(
            id: "id",
            name: "name",
          ),
          url: "url",
          author: "author",
          content: "content",
        ),
        NewsArticleModel(
          title: "title2",
          urlToImage: "urlToImage",
          description: "description",
          publishedAt: "publishedAt",
          source: SourceModel(
            id: "id",
            name: "name",
          ),
          url: "url",
          author: "author",
          content: "content",
        ),
      ],
    );

    when(mockDataSource.getNewsArticles(testFilter)).thenAnswer(
      (_) async => Success(data: responseModel),
    );

    final result = await repository.getNewsArticles(testFilter);

    expect(result, isA<Success>());
    final articles = (result as Success).data;
    expect(articles, isA<List<NewsArticle>>());
    expect(articles.length, 2);
    expect(articles[0].title, "title1");
    expect(articles[1].title, "title2");
  });

  test('get news articles failure', () async {
    when(mockDataSource.getNewsArticles(testFilter)).thenAnswer(
      (_) async => Failure(message: "Error"),
    );

    final result = await repository.getNewsArticles(testFilter);

    expect(result, isA<Failure>());
    expect((result as Failure).message, "Error");
  });
}
