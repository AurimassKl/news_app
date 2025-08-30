import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_state.dart';
import 'package:newsapp/presentation/pages/widgets/filters/category_dropdown.dart';
import 'package:newsapp/presentation/pages/widgets/filters/country_dropdown.dart';
import 'package:newsapp/presentation/pages/widgets/filters/quarry_text_field.dart';
import 'package:newsapp/presentation/pages/widgets/filters/source_dropdown.dart';

class NewsFilterBar extends StatefulWidget {
  const NewsFilterBar({super.key});

  @override
  State<NewsFilterBar> createState() => _NewsFilterBarState();
}

class _NewsFilterBarState extends State<NewsFilterBar> {
  late TextEditingController _queryController;
  static const categories = [
    "Business",
    "Entertainment",
    "general",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];

  @override
  void initState() {
    super.initState();
    final bloc = context.read<NewsArticlesBloc>();
    _queryController = TextEditingController(text: bloc.currentFilter.query ?? "");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocBuilder<NewsArticlesBloc, NewsArticlesState>(
      builder: (context, state) {
        final articlesBloc = context.read<NewsArticlesBloc>();
        final currentFilter = articlesBloc.currentFilter;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 20,
              children: [
                CountryDropdownButton(currentFilter: currentFilter, articlesBloc: articlesBloc),
                CategoryDropdownButton(currentFilter: currentFilter, categories: categories, articlesBloc: articlesBloc),
                SourceDropdownButton(currentFilter: currentFilter, articlesBloc: articlesBloc),
                QuarryTextField(queryController: _queryController, currentFilter: currentFilter, articlesBloc: articlesBloc),
              ],
            ),
          ),
        );
      },
    );
  }
}
