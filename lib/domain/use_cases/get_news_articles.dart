import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';

class GetNewsArticles {
  GetNewsArticles(this._repository);

  final NewsArticlesRepository _repository;

  Future<Result<List<NewsArticle>>> call() {
    return _repository.getNewsArticles();
  }
}
