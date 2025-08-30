import 'package:dio/dio.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_source/news_source_data_source.dart';
import 'package:newsapp/data/models/news_source_responce/news_source_response_model.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';

class NewsSourcesDataSourceLocalImpl implements NewsSourcesDataSource {
  final Dio dio;

  NewsSourcesDataSourceLocalImpl(this.dio);
  @override
  Future<Result<NewsSourceResponseModel>> getNewsSources(NewsSourceFilter filter) async {
    try {
      final response = {
        "status": "ok",
        "sources": [
          {
            "id": "abc-news",
            "name": "ABC News",
            "description": "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
            "url": "https://abcnews.go.com",
            "category": "general",
            "language": "en",
            "country": "us"
          },
          {
            "id": "al-jazeera-english",
            "name": "Al Jazeera English",
            "description":
                "News, analysis from the Middle East and worldwide, multimedia and interactives, opinions, documentaries, podcasts, long reads and broadcast schedule.",
            "url": "https://www.aljazeera.com",
            "category": "general",
            "language": "en",
            "country": "us"
          },
          {
            "id": "ars-technica",
            "name": "Ars Technica",
            "description": "The PC enthusiast's resource. Power users and the tools they love, without computing religion.",
            "url": "https://arstechnica.com",
            "category": "technology",
            "language": "en",
            "country": "us"
          },
          {
            "id": "associated-press",
            "name": "Associated Press",
            "description": "The AP delivers in-depth coverage on the international, politics, lifestyle, business, and entertainment news.",
            "url": "https://apnews.com/",
            "category": "general",
            "language": "en",
            "country": "us"
          }
        ]
      };
      final responseModel = NewsSourceResponseModel.fromJson(response);
      return Success(data: responseModel);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return Failure(message: e.toString());
    }
  }
}
