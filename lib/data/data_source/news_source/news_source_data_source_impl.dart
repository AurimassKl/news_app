import 'package:dio/dio.dart';
import 'package:newsapp/core/variables.dart';
import 'package:newsapp/data/data_source/news_source/news_source_data_source.dart';
import 'package:newsapp/data/models/news_source/news_source_model.dart';
import 'package:newsapp/data/models/news_source_responce/news_source_response_model.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';

class NewsSourcesDataSourceImpl implements NewsSourcesDataSource {
  final Dio dio;

  NewsSourcesDataSourceImpl(this.dio);

  @override
  Future<List<NewsSourceModel>> getNewsSources(NewsSourceFilter filter) async {
    try {
      print(filter.country);
      final response = await dio.get("v2/top-headlines/sources", queryParameters: {...filter.toModel().toJson(), "apiKey": newsApiKey});
      final responseModel = NewsSourceResponseModel.fromJson(response.data);

      if (responseModel.status == "ok") {
        final sources = responseModel.sources;
        return sources;
      } else {
        print(responseModel.status);
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
    }
    return [];
  }
}
