import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:newsapp/core/dio_client.dart';
import 'package:newsapp/data/data_source/news_articles/news_articles_data_souce_local_impl.dart';
import 'package:newsapp/data/data_source/news_articles/news_articles_data_source.dart';
import 'package:newsapp/data/data_source/news_source/news_source_data_souce_local_impl.dart';
import 'package:newsapp/data/data_source/news_source/news_source_data_source.dart';
import 'package:newsapp/data/repositories/news_article_repository_impl.dart';
import 'package:newsapp/data/repositories/news_source_repository_impl.dart';
import 'package:newsapp/domain/repositories/news_repository.dart';
import 'package:newsapp/domain/repositories/news_sources_repository.dart';
import 'package:newsapp/domain/use_cases/get_news_articles.dart';
import 'package:newsapp/domain/use_cases/get_news_sources_article.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  sl.registerLazySingleton<Dio>(() => newsApiDio());

  sl.registerLazySingleton<NewsArticlesDataSource>(() => NewsArticlesDataSourceLocalImpl(sl()));

  sl.registerLazySingleton<NewsArticlesRepository>(() => NewsArticlesRepositoryImpl(sl()));

  sl.registerFactory(() => GetNewsArticles(sl()));

  sl.registerLazySingleton<NewsSourcesDataSource>(() => NewsSourcesDataSourceLocalImpl(sl()));

  sl.registerLazySingleton<NewsSourcesRepository>(() => NewsSourcesRepositoryImpl(sl()));

  sl.registerFactory(() => GetNewsSources(sl()));
}
