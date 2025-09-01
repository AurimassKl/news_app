import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_source/news_source_data_source_impl.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';

import 'news_source_data_source_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late NewsSourcesDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = NewsSourcesDataSourceImpl(mockDio);
  });
  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    dotenv.env['NEWS_API_KEY'] = 'fake_api_key';
  });

  test('News sources response status ok', () async {
    final responsePayload = {
      "status": "ok",
      "sources": [
        {
          "id": "id",
          "name": "name",
          "description": "description",
          "url": "url",
          "category": "category",
          "language": "language",
          "country": "country",
        }
      ],
    };

    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: responsePayload,
          statusCode: 200,
          requestOptions: RequestOptions(path: 'v2/top-headlines'),
        ));

    final result = await dataSource.getNewsSources(NewsSourceFilter(country: "us"));

    expect(result, isA<Success>());
    expect((result as Success).data?.status, "ok");
  });

  test('News source response status error missing api key', () async {
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

    final result = await dataSource.getNewsSources(NewsSourceFilter(country: "us"));

    expect(result, isA<Success>());
    expect((result as Success).data?.status, "error");
    expect((result as Success).data?.code, "apiKeyMissing");
  });

  test('News source response status error parameter', () async {
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

    final result = await dataSource.getNewsSources(NewsSourceFilter(country: "us"));

    expect(result, isA<Success>());
    expect((result as Success).data?.status, "error");
    expect((result as Success).data?.code, "parametersMissing");
  });
}
