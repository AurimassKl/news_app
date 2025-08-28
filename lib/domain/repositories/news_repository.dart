import 'package:newsapp/domain/entities/news_article.dart';

abstract class NewsArticlesRepository {
  Future<List<NewsArticle>> getNewsArticles();
}
