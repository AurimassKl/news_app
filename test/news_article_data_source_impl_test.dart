import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_articles/news_articles_data_source_impl.dart';
import 'package:newsapp/domain/entities/news_filter.dart';

import 'news_article_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late NewsArticlesDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = NewsArticlesDataSourceImpl(mockDio);
  });
  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    dotenv.env['NEWS_API_KEY'] = 'fake_api_key';
  });

  test('News articles response status ok', () async {
    final responsePayload = {
      "status": "ok",
      "totalResults": 1,
      "articles": [
        {
          "source": {"id": "id", "name": "name"},
          "author": "author",
          "title": "title",
          "description": "description",
          "url": "url",
          "urlToImage": "urlToImage",
          "publishedAt": "publishedAt",
          "content": "content"
        }
      ]
    };

    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: responsePayload,
          statusCode: 200,
          requestOptions: RequestOptions(path: 'v2/top-headlines'),
        ));

    final result = await dataSource.getNewsArticles(NewsFilter(country: "us"));

    expect(result, isA<Success>());
    expect((result as Success).data?.status, "ok");
  });

  test('News articles response status error missing api key', () async {
    final responsePayload = {
      "status": "error",
      "code": "apiKeyMissing",
      "message": "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header.",
    };

    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: responsePayload,
          statusCode: 401,
          requestOptions: RequestOptions(path: 'v2/top-headlines'),
        ));

    final result = await dataSource.getNewsArticles(NewsFilter(country: "us"));

    expect(result, isA<Success>());
    expect((result as Success).data?.status, "error");
    expect((result as Success).data?.code, "apiKeyMissing");
  });

  test('News articles response status error parameter', () async {
    final responsePayload = {
      "status": "error",
      "code": "parametersMissing",
      "message":
          "Required parameters are missing. Please set any of the following parameters and try again: sources, q, language, country, category.",
    };

    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: responsePayload,
          statusCode: 401,
          requestOptions: RequestOptions(path: 'v2/top-headlines'),
        ));

    final result = await dataSource.getNewsArticles(NewsFilter(country: "us"));

    expect(result, isA<Success>());
    expect((result as Success).data?.status, "error");
    expect((result as Success).data?.code, "parametersMissing");
  });
}
