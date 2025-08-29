import 'package:flutter_dotenv/flutter_dotenv.dart';

String newsBaseUrl = dotenv.env["NEWS_SOURCE_API"] ?? "https://newsapi.org/";
String newsApiKey = dotenv.env["NEWS_SOURCE_API_KEY"] ?? "";
