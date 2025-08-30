import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/models/news_response/news_response_model.dart';
import 'package:newsapp/domain/entities/news_filter.dart';

abstract class NewsArticlesDataSource {
  Future<Result<NewsResponseModel>> getNewsArticles(NewsFilter filter);
}
