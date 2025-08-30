import 'package:dio/dio.dart';
import 'package:newsapp/core/result.dart';
import 'package:newsapp/data/data_source/news_articles/news_articles_data_source.dart';
import 'package:newsapp/data/models/news_response/news_response_model.dart';
import 'package:newsapp/domain/entities/news_filter.dart';

class NewsArticlesDataSourceLocalImpl implements NewsArticlesDataSource {
  final Dio dio;

  NewsArticlesDataSourceLocalImpl(this.dio);

  @override
  Future<Result<NewsResponseModel>> getNewsArticles(NewsFilter filter) async {
    try {
      final response = {
        "status": "ok",
        "totalResults": 36,
        "articles": [
          {
            "source": {"id": "axios", "name": "Axios"},
            "author": "Ben Berkowitz, Courtenay Brown, Madison Mills",
            "title": "Federal appellate court upholds ruling striking down Trump's tariffs - Axios",
            "description": "A trade court ruled in May that Trump did not have the authority to impose broad global tariffs.",
            "url": "https://www.axios.com/2025/08/29/trump-tariffs-ruling-ieepa",
            "urlToImage": "https://images.axios.com/T6gnWTj8_psMftdwDP2FW2U7xXg=/0x0:4953x2786/1366x768/2025/08/08/1754667546338.jpeg",
            "publishedAt": "2025-08-30T15:00:44Z",
            "content":
                "<ul><li>Trump said the ruling would \"literally destroy the United States of America\" if it stands, and promised an appeal to the Supreme Court. </li></ul>The big picture: Trump has secured historic t… [+3607 chars]"
          },
          {
            "source": {"id": "cnn", "name": "CNN"},
            "author": "Alicia Wallace, Dalia Faheid, Arit John",
            "title":
                "Generations celebrated weddings, baptisms and first communions at this Minneapolis church before it became a site of tragedy - CNN",
            "description":
                "Wednesday’s shooting has left a century-old Catholic institution – long considered a bedrock of faith, family and education – reeling.",
            "url": "https://www.cnn.com/2025/08/30/us/minneapolis-shooting-annunciation-church-community",
            "urlToImage": "https://media.cnn.com/api/v1/images/stellar/prod/01-gettyimages-2231705776.jpg?c=16x9&q=w_800,c_fill",
            "publishedAt": "2025-08-30T15:00:00Z",
            "content":
                "On late-August mornings in the Windom neighborhood, the soundscape is usually familiar and comforting. Cicadas buzz, sparrows dart between yards, neighbors trade easy greetings across tidy sidewalks … [+9755 chars]"
          },
          {
            "source": {"id": "cnn", "name": "CNN"},
            "author": "Allison Morrow",
            "title": "Why Wall Street has developed an unhealthy obsession with Nvidia - CNN",
            "description":
                "For markets, the most important story of the week was, somehow, not the president’s attempted firing of top Federal Reserve official. Instead, it was Nvidia’s earnings report, a quarterly event that, in the finance world, has taken on Super Bowl-level importa…",
            "url": "https://www.cnn.com/2025/08/30/business/nvidia-wall-street-nightcap",
            "urlToImage": "https://media.cnn.com/api/v1/images/stellar/prod/ap25212403035947.jpg?c=16x9&q=w_800,c_fill",
            "publishedAt": "2025-08-30T15:00:00Z",
            "content":
                "A version of this story appeared in CNN Business Nightcap newsletter. To get it in your inbox, sign up for free here.\r\nFor markets, the most important story of the week was, somehow, not the presiden… [+4692 chars]"
          }
        ]
      };
      final responseModel = NewsResponseModel.fromJson(response);
      return Success(data: responseModel);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return Failure(message: e.toString());
    }
  }
}
