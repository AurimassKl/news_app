import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/domain/entities/news_filter.dart';
import 'package:newsapp/domain/entities/news_sources.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_bloc.dart';
import 'package:newsapp/presentation/bloc/news_articles/news_articles_event.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_bloc.dart';
import 'package:newsapp/presentation/bloc/news_source/news_sources_state.dart';
import 'package:newsapp/presentation/pages/widgets/filters/dropdown_style.dart';

class SourceDropdownButton extends StatelessWidget {
  const SourceDropdownButton({
    super.key,
    required this.currentFilter,
    required this.articlesBloc,
  });

  final NewsFilter currentFilter;
  final NewsArticlesBloc articlesBloc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<NewsSourcesBloc, NewsSourcesState>(
      builder: (context, sourcesState) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: currentFilter.sources,
            hint: Text(
              "Sources",
              style: AppDropdownStyles.hintTextStyle(
                fontSize: SizeConfig.screenWidth * 0.04,
              ),
            ),
            items: [
              const DropdownMenuItem<String>(
                value: "",
                child: Text("All"),
              ),
              ...(sourcesState is NewsSourcesFetchedState ? sourcesState.newsSources : <NewsSource>[]).map(
                (src) {
                  return DropdownMenuItem<String>(
                    value: src.id,
                    child: Text(src.name),
                  );
                },
              )
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
            selectedItemBuilder: (context) {
              return [
                for (var c in ["", ...(sourcesState is NewsSourcesFetchedState ? sourcesState.newsSources : <NewsSource>[]).map((src) => src)])
                  SizedBox(
                    width: 140,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        style: AppDropdownStyles.buttonTextStyle(),
                        c == "" ? "Source" : (c as NewsSource).name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ];
            },
            buttonStyleData: AppDropdownStyles.buttonStyle(width: 200),
            dropdownStyleData: AppDropdownStyles.dropdownStyle(),
            menuItemStyleData: AppDropdownStyles.menuItemStyle(),
          ),
        );
      },
    );
  }
}
