import 'package:go_router/go_router.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:newsapp/presentation/pages/news_detail/news_detail.dart';
import 'package:newsapp/presentation/pages/news_list/news_list.dart';

GoRouter buildRouter() => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const NewsListPage(),
          routes: [
            GoRoute(
              path: "details",
              builder: (context, state) {
                final article = state.extra as NewsArticle;
                return NewsDetailPage(article: article);
              },
            ),
          ],
        ),
      ],
    );
