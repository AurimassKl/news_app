import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/models/news_source_responce/news_source_response_model.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';

abstract class NewsSourcesDataSource {
  Future<Result<NewsSourceResponseModel>> getNewsSources(NewsSourceFilter filter);
}
