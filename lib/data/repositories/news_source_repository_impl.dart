import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_source/news_source_data_source.dart';
import 'package:newsapp/data/models/news_source_responce/news_source_response_model.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/domain/entities/news_sources.dart';
import 'package:newsapp/domain/repositories/news_sources_repository.dart';

class NewsSourcesRepositoryImpl implements NewsSourcesRepository {
  final NewsSourcesDataSource dataSource;

  NewsSourcesRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<NewsSource>>> getNewsSources(NewsSourceFilter filter) async {
    try {
      final Result result = await dataSource.getNewsSources(filter);
      if (result is Success) {
        final response = result.data as NewsSourceResponseModel;
        if (response.status == "ok") {
          final articles = (response.sources ?? []).map((e) => e.toEntity()).toList();
          return Success(data: articles);
        }
        return Failure(message: response.message!);
      }
      return Failure(message: (result as Failure).message);
    } catch (e) {
      return Failure(message: e.toString());
    }
  }
}
