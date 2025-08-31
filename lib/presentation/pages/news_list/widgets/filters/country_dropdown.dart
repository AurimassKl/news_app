import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/entities/news_source_filter.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_bloc.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_event.dart';
import 'package:newsapp/presentation/pages/news_list/widgets/filters/dropdown_style.dart';
import 'package:sealed_countries/sealed_countries.dart';

class CountryDropdownButton extends StatelessWidget {
  const CountryDropdownButton({
    super.key,
    required this.currentFilter,
    required this.articlesBloc,
  });

  final NewsFilter currentFilter;
  final NewsArticlesBloc articlesBloc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          "Countries",
          style: AppDropdownStyles.hintTextStyle(
            fontSize: SizeConfig.screenWidth * 0.04,
          ),
        ),
        items: [
          const DropdownMenuItem<String>(
            value: "",
            child: Text("All"),
          ),
          ...WorldCountry.list.map((c) {
            return DropdownMenuItem<String>(
              value: c.codeShort.toLowerCase(),
              child: Text(
                "${c.emoji} ${c.name.common}",
                overflow: TextOverflow.visible,
              ),
            );
          })
        ],
        value: currentFilter.country,
        onChanged: (val) {
          if (val == null) return;

          final newFilter = currentFilter.copyWith(
            country: val,
            sources: "",
          );
          articlesBloc.add(FetchNewsArticles(newFilter));
          context.read<NewsSourcesBloc>().add(FetchNewsSources(NewsSourceFilter(country: val)));
        },
        buttonStyleData: AppDropdownStyles.buttonStyle(width: 200),
        dropdownStyleData: AppDropdownStyles.dropdownStyle(),
        menuItemStyleData: AppDropdownStyles.menuItemStyle(),
        selectedItemBuilder: (context) {
          return [
            for (var c in ["", ...WorldCountry.list.map((e) => e.codeShort)])
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  style: AppDropdownStyles.buttonTextStyle(),
                  c == ""
                      ? "All"
                      : (() {
                          final country = WorldCountry.fromCodeShort(c);
                          return "${country.emoji} ${country.name.fullName}";
                        })(),
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
