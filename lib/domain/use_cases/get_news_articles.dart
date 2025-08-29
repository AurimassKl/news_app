import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';

class GetNewsArticles {
  final NewsArticlesRepository _repo;

  GetNewsArticles(this._repo);

  Future<Result<List<NewsArticle>>> call(NewsFilter newsFilter) async {
    return await _repo.getNewsArticles(newsFilter);
  }
}
