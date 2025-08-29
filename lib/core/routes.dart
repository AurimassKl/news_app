import 'package:go_router/go_router.dart';
import 'package:newsapp/presentation/pages/news_list.dart';

GoRouter buildRouter() => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const NewsListPage(),
          // routes: [
          //   GoRoute(
          //     path: "details",
          //     builder: (context, state) => NewsDetailsScreen(),
          //   ),
          // ],
        ),
      ],
    );
