import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';

class NewsArticles {
  final NewsRepository repository;

  NewsArticles(this.repository);

  Future<List<NewsArticle>> listNews() async {
    return repository.getNewsArticles();
  }
}
