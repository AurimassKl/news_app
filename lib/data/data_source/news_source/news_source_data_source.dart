import 'package:newsapp/data/models/news_source/news_source_model.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';

abstract class NewsSourcesDataSource {
  Future<List<NewsSourceModel>> getNewsSources(NewsSourceFilter filter);
}
