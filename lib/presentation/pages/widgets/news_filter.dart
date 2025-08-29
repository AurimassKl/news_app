import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/domain/entities/news_sources.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_state.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_bloc.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_event.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_state.dart';
import 'package:sealed_countries/sealed_countries.dart';

class NewsFilterBar extends StatelessWidget {
  const NewsFilterBar({super.key});

  static const categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocBuilder<NewsArticlesBloc, NewsArticlesState>(
      builder: (context, state) {
        final articlesBloc = context.read<NewsArticlesBloc>();
        final currentFilter = articlesBloc.currentFilter;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DropdownButton<String>(
                value: currentFilter.country,
                items: [
                  const DropdownMenuItem<String>(
                    value: "",
                    child: Text("All"),
                  ),
                  ...WorldCountry.list.map((c) {
                    return DropdownMenuItem<String>(
                      value: c.codeShort.toLowerCase(),
                      child: Text("${c.emoji} ${c.name.common}"),
                    );
                  }).toList()
                ],
                onChanged: (val) {
                  if (val == null) return;

                  final newFilter = currentFilter.copyWith(
                    country: val,
                    sources: "",
                  );
                  articlesBloc.add(FetchNewsArticles(newFilter));
                  context.read<NewsSourcesBloc>().add(FetchNewsSources(NewsSourceFilter(country: val)));
                },
              ),
              DropdownButton<String>(
                value: currentFilter.category,
                hint: const Text("Category"),
                items: [
                  const DropdownMenuItem<String>(
                    value: "",
                    child: Text("Category"),
                  ),
                  ...categories.map(
                    (cat) {
                      return DropdownMenuItem<String>(
                        value: cat,
                        child: Text(cat),
                      );
                    },
                  )
                ],
                onChanged: (val) {
                  if (val == null) return;
                  final newFilter = currentFilter.copyWith(
                    category: val,
                    sources: "",
                  );
                  articlesBloc.add(FetchNewsArticles(newFilter));
                },
              ),
              BlocBuilder<NewsSourcesBloc, NewsSourcesState>(
                builder: (context, sourcesState) {
                  return DropdownButton<String>(
                    value: currentFilter.sources,
                    hint: const Text("Source"),
                    items: [
                      const DropdownMenuItem<String>(
                        value: "",
                        child: Text("Source"),
                      ),
                      ...(sourcesState is NewsSourcesFetchedState ? sourcesState.newsSources : <NewsSource>[]).map(
                        (src) {
                          return DropdownMenuItem<String>(
                            value: src.id,
                            child: Text(src.name),
                          );
                        },
                      ).toList()
                    ],
                    onChanged: (val) {
                      if (val == null) return;
                      final newFilter = currentFilter.copyWith(
                        sources: val,
                        country: "",
                        category: "",
                      );
                      articlesBloc.add(FetchNewsArticles(newFilter));
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
