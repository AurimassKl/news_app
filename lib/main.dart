import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsapp/core/colors.dart';
import 'package:newsapp/core/routes.dart';
import 'package:newsapp/di/di.dart';
import 'package:newsapp/domain/use_cases/get_news_articles.dart';
import 'package:newsapp/domain/use_cases/get_news_sources_article.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = buildRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NewsArticlesBloc(sl<GetNewsArticles>())),
        BlocProvider(create: (_) => NewsSourcesBloc(sl<GetNewsSources>())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        builder: (context, child) {
          return SafeArea(
            bottom: true,
            child: child!,
          );
        },
      ),
    );
  }
}
