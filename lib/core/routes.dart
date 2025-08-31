import 'package:flutter/material.dart';
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
              pageBuilder: (context, state) {
                final article = state.extra as NewsArticle;
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: NewsDetailPage(article: article),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    final tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: Curves.easeInOut),
                    );
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
