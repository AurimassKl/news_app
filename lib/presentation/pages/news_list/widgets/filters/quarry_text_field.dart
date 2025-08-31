import 'package:flutter/material.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/core/colors.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/pages/news_list/widgets/filters/dropdown_style.dart';

class QuarryTextField extends StatelessWidget {
  const QuarryTextField({
    super.key,
    required TextEditingController queryController,
    required this.currentFilter,
    required this.articlesBloc,
  }) : _queryController = queryController;

  final TextEditingController _queryController;
  final NewsFilter currentFilter;
  final NewsArticlesBloc articlesBloc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
      height: AppDropdownStyles.height,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(14),
        child: TextField(
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.screenWidth * 0.04,
          ),
          controller: _queryController,
          decoration: InputDecoration(
            hintStyle: AppDropdownStyles.hintTextStyle(
              fontSize: SizeConfig.screenWidth * 0.04,
            ),
            hintText: "Search query",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDropdownStyles.horizontalPadding,
              vertical: 0,
            ),
            filled: true,
            fillColor: kSearchQuarryColor,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _queryController.clear();
                final newFilter = currentFilter.copyWith(query: "");
                articlesBloc.add(FetchNewsArticles(newFilter));
              },
            ),
          ),
          onSubmitted: (val) {
            final newFilter = currentFilter.copyWith(query: val.isEmpty ? "" : val);
            articlesBloc.add(FetchNewsArticles(newFilter));
          },
        ),
      ),
    );
  }
}
