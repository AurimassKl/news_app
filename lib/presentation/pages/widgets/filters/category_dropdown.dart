import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/pages/widgets/filters/dropdown_style.dart';

class CategoryDropdownButton extends StatelessWidget {
  const CategoryDropdownButton({
    super.key,
    required this.currentFilter,
    required this.categories,
    required this.articlesBloc,
  });

  final NewsFilter currentFilter;
  final List<String> categories;
  final NewsArticlesBloc articlesBloc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        value: currentFilter.category,
        hint: Text(
          "Categories",
          style: AppDropdownStyles.hintTextStyle(
            fontSize: SizeConfig.screenWidth * 0.04,
          ),
        ),
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
        buttonStyleData: AppDropdownStyles.buttonStyle(width: 200),
        dropdownStyleData: AppDropdownStyles.dropdownStyle(),
        menuItemStyleData: AppDropdownStyles.menuItemStyle(),
        selectedItemBuilder: (context) {
          return [
            for (var c in ["", ...categories])
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  style: AppDropdownStyles.buttonTextStyle(),
                  c == "" ? "Category" : c,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ];
        },
      ),
    );
  }
}
