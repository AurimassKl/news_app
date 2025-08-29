import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_articles_data_source.dart';
import 'package:newsapp/data/models/news_article/news_article_model.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';

class NewsArticlesRepositoryImpl implements NewsArticlesRepository {
  final NewsArticlesDataSource dataSource;

  NewsArticlesRepositoryImpl(this.dataSource);

  @override
  Future<Result<List<NewsArticle>>> getNewsArticles(NewsFilter filter) async {
    try {
      final List<NewsArticleModel> result = await dataSource.getNewsArticles(filter);
      final articles = result.map((e) => e.toEntity()).toList();
      return Success(articles);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
