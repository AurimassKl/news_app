import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => NewsListScreen(),
      routes: [
        GoRoute(
          path: "details",
          builder: (context, state) => NewsDetailsScreen(),
        ),
      ],
    ),
  ],
);
