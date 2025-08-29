import 'package:newsapp/data/models/news_article/news_article_model.dart';
import 'package:newsapp/domain/entities/news_filter.dart';

abstract class NewsArticlesDataSource {
  Future<List<NewsArticleModel>> getNewsArticles(NewsFilter filter);
}
