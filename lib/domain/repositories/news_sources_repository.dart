import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/domain/entities/news_sources.dart';

abstract class NewsSourcesRepository {
  Future<Result<List<NewsSource>>> getNewsSources(NewsSourceFilter newsSourceFilter);
}
