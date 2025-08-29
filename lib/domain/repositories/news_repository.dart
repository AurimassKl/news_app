import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_article.dart';

abstract class NewsArticlesRepository {
  Future<Result<List<NewsArticle>>> getNewsArticles();
}
