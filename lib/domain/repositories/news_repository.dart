import 'package:newsapp/core/result.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';

abstract class NewsArticlesRepository {
  Future<Result<List<NewsArticle>>> getNewsArticles(NewsFilter newsFilter);
}
