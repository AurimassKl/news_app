import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_source/news_source_data_source.dart';
import 'package:newsapp/data/models/news_source/news_source_model.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/domain/entities/news_sources.dart';
import 'package:newsapp/domain/repositories/news_source.dart';

class NewsSourceRepositoryImpl implements NewsSourceRepository {
  final NewsSourceDataSource dataSource;

  NewsSourceRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<NewsSource>>> getNewsSources(NewsSourceFilter filter) async {
    try {
      final List<NewsSourceModel> result = await dataSource.getNewsSources(filter);
      final sources = result.map((e) => e.toEntity()).toList();
      return Success(sources);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
