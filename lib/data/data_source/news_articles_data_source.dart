import 'package:newsapp/data/models/news_article/news_article_model.dart';

abstract class NewsArticlesDataSource {
  Future<List<NewsArticleModel>> getNewsArticles();
}
