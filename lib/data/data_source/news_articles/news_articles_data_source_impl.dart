import 'package:dio/dio.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/core/variables.dart';
import 'package:newsapp/data/data_source/news_articles/news_articles_data_source.dart';
import 'package:newsapp/data/models/news_response/news_response_model.dart';
import 'package:newsapp/domain/entities/news_filter.dart';

class NewsArticlesDataSourceImpl implements NewsArticlesDataSource {
  final Dio dio;

  NewsArticlesDataSourceImpl(this.dio);

  @override
  Future<Result<NewsResponseModel>> getNewsArticles(NewsFilter filter) async {
    try {
      final response = await dio.get(
        "v2/top-headlines",
        queryParameters: {...filter.toModel().toJson(), "apiKey": newsApiKey},
      );
      final responseModel = NewsResponseModel.fromJson(response.data);
      return Success(data: responseModel);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return Failure(message: e.toString());
    }
  }
}
