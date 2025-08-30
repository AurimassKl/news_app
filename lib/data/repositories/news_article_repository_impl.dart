import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_articles/news_articles_data_source.dart';
import 'package:newsapp/data/models/news_response/news_response_model.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';

class NewsArticlesRepositoryImpl implements NewsArticlesRepository {
  final NewsArticlesDataSource dataSource;

  NewsArticlesRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<NewsArticle>>> getNewsArticles(NewsFilter filter) async {
    try {
      final Result result = await dataSource.getNewsArticles(filter);
      if (result is Success) {
        final response = result.data as NewsResponseModel;
        if (response.status == "ok") {
          final articles = (response.articles ?? []).map((e) => e.toEntity()).toList();
          return Success(data: articles);
        }
        return Failure(message: response.message!);
      }
      return Failure(message: (result as Failure).message);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return Failure(message: e.toString());
    }
  }
}
