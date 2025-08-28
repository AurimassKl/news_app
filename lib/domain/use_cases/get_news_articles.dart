import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';

class GetNewsArticles {
  GetNewsArticles(this.newsArticleRepository);

  final NewsArticlesRepository newsArticleRepository;

  Future<List<NewsArticle>> getNewsArticles() {
    return newsArticleRepository.getNewsArticles();
  }
}
