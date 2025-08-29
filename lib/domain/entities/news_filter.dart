import 'package:newsapp/data/models/news_filter/news_filter_model.dart';

class NewsFilter {
  final String? country;
  final String? category;
  final String? sources;
  final String? query;

  const NewsFilter({this.country, this.category, this.sources, this.query});

  NewsFilter copyWith({
    String? country,
    String? category,
    String? sources,
    String? query,
  }) {
    return NewsFilter(
      country: country ?? this.country,
      category: category ?? this.category,
      sources: sources ?? this.sources,
      query: query ?? this.query,
    );
  }

  NewsFilterModel toModel() {
    return NewsFilterModel(
      country: country,
      category: category,
      sources: sources,
      query: query,
    );
  }
}
