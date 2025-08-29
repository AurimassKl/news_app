import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/domain/entities/news_sources.dart';
import 'package:newsapp/domain/repositories/news_sources_repository.dart';

class GetNewsSources {
  final NewsSourcesRepository _repo;

  GetNewsSources(this._repo);

  Future<Result<List<NewsSource>>> call(NewsSourceFilter newsSourceFilter) async {
    return await _repo.getNewsSources(newsSourceFilter);
  }
}
