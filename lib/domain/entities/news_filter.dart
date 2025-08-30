import 'package:newsapp/data/models/news_filter/news_filter_model.dart';

class NewsFilter {
  final String? country;
  final String? category;
  final String? sources;
  final String? query;
  final int page;
  final int pageSize;

  const NewsFilter({this.country, this.category, this.sources, this.query, this.page = 1, this.pageSize = 20});

  NewsFilter copyWith({
    String? country,
    String? category,
    String? sources,
    String? query,
    int? page,
    int? pageSize,
  }) {
    return NewsFilter(
      country: country ?? this.country,
      category: category ?? this.category,
      sources: sources ?? this.sources,
      query: query ?? this.query,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  NewsFilterModel toModel() {
    return NewsFilterModel(
      country: country,
      category: category,
      sources: sources,
      q: query,
      page: page,
      pageSize: pageSize,
    );
  }
}
