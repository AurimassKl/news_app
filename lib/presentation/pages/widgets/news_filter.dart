import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_state.dart';
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
        final bloc = context.read<NewsArticlesBloc>();
        final currentFilter = bloc.currentFilter;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DropdownButton<String>(
                value: currentFilter.country,
                items: WorldCountry.list.map((c) {
                  return DropdownMenuItem<String>(
                    value: c.codeShort.toLowerCase(),
                    child: Text("${c.emoji} ${c.name.common}"),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val == null) return;

                  final newFilter = currentFilter.copyWith(country: val);
                  bloc.add(FetchNewsArticles(newFilter));
                },
              ),
              DropdownButton<String>(
                value: currentFilter.category,
                hint: const Text("Category"),
                items: categories.map((cat) {
                  return DropdownMenuItem<String>(
                    value: cat,
                    child: Text(cat[0].toUpperCase() + cat.substring(1)),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val == null) return;
                  final newFilter = currentFilter.copyWith(category: val);
                  bloc.add(FetchNewsArticles(newFilter));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
