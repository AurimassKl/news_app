import 'package:dio/dio.dart';
import 'package:newsapp/core/variables.dart';

Dio newsApiDio() {
  return Dio(BaseOptions(baseUrl: newsBaseUrl));
}
