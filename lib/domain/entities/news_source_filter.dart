import 'package:newsapp/data/models/news_source_filter/news_source_filter_model.dart';

class NewsSourceFilter {
  final String? category;
  final String? language;
  final String? country;

  const NewsSourceFilter({this.category, this.language, this.country});

  NewsSourceFilter copyWith({
    String? category,
    String? language,
    String? country,
  }) {
    return NewsSourceFilter(
      category: category ?? this.category,
      language: language ?? this.language,
      country: country ?? this.country,
    );
  }

  NewsSourceFilterModel toModel() {
    return NewsSourceFilterModel(
      category: category,
      language: language,
      country: country,
    );
  }
}
