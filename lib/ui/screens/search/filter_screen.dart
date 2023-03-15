import 'package:bibliotheque/blocs/categories_bloc.dart';
import 'package:bibliotheque/blocs/search_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/entities/filter_options.dart';
import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/models/category.dart';
import 'package:bibliotheque/repos/search_repo.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/widgets/range_selector.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterScreen extends StatefulWidget {
  // TODO: handle filter screen for category and wish list screens
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late SortingMethod sortingMethod;
  late RatingRange ratingRange;
  late Language filterLanguage;
  late AgeRange ageRange;

  Map<Category, bool> searchCategories = {};
  List<Category> allCategories = [];

  late int startPrice;
  late int endPrice;

  @override
  void initState() {
    super.initState();
    final options = BlocProvider.of<SearchBloc>(context).state.filterOptions;
    sortingMethod = options.sortingMethod;
    ratingRange = options.ratingRange;
    filterLanguage = options.language;
    ageRange = options.ageRange;
    startPrice = options.startPrice;
    endPrice = options.endPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Svg(
            'close.svg',
            size: 20,
            color: context.theme.iconColor1,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<CategoriesBloc, CategoriesState>(
          listener: (context, state) {
            if (state.status == CategoriesStatus.success) {
              allCategories = state.categories!;
              loadSubCategories(
                BlocProvider.of<SearchBloc>(context)
                    .state
                    .filterOptions
                    .categories
                    .map((e) => e.id)
                    .toList(),
              );
            }
          },
          builder: (context, state) {
            if (state.status == CategoriesStatus.loading) {
              return const Center(
                child: AppProgressIndicator(),
              );
            }

            if (state.status == CategoriesStatus.error) {
              return TryAgainWidget(
                onPressed: () {
                  BlocProvider.of<CategoriesBloc>(context).add(
                    LoadCategories(allCategories: true),
                  );
                },
              );
            }

            return ListView(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: context.theme.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: context.theme.filterCardBackground.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Text(
                          "Sort",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.textColor1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...SortingMethod.values
                          .map(
                            (method) => Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.5,
                                    color: context.theme.dividerColor,
                                  ),
                                ),
                              ),
                              child: RadioListTile(
                                value: method,
                                groupValue: sortingMethod,
                                title: Text(
                                  sortingMethodToText(method),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    sortingMethod = method;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: context.theme.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: context.theme.filterCardBackground.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.textColor1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 15),
                      RangeSelector(
                        start: 1,
                        step: 1,
                        end: 50,
                        quantityName: "Dollars",
                        initialStart: startPrice.toDouble(),
                        initialEnd: endPrice.toDouble(),
                        onChanged: (start, end) {
                          setState(() {
                            startPrice = start.toInt();
                            endPrice = end.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: context.theme.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: context.theme.filterCardBackground.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Text(
                          "Rating",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.textColor1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...RatingRange.values
                          .map(
                            (rate) => Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.5,
                                    color: context.theme.dividerColor,
                                  ),
                                ),
                              ),
                              child: RadioListTile(
                                value: rate,
                                groupValue: ratingRange,
                                title: Text(
                                  ratingRangeToText(rate),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ratingRange = rate;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: context.theme.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: context.theme.filterCardBackground.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Text(
                          "Genre",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.textColor1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...searchCategories.entries
                          .map(
                            (entry) => Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.5,
                                    color: context.theme.dividerColor,
                                  ),
                                ),
                              ),
                              child: CheckboxListTile(
                                value: entry.value,
                                title: Text(
                                  entry.key.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() {
                                    searchCategories[entry.key] = value;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: context.theme.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: context.theme.filterCardBackground.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Text(
                          "Language",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.textColor1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...Language.values
                          .map(
                            (language) => Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.5,
                                    color: context.theme.dividerColor,
                                  ),
                                ),
                              ),
                              child: RadioListTile(
                                value: language,
                                groupValue: filterLanguage,
                                title: Text(
                                  languageToText(language),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    filterLanguage = language;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: context.theme.dividerColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: context.theme.filterCardBackground.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Text(
                          "Age",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.textColor1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ...AgeRange.values
                          .map(
                            (age) => Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.5,
                                    color: context.theme.dividerColor,
                                  ),
                                ),
                              ),
                              child: RadioListTile(
                                value: age,
                                groupValue: ageRange,
                                title: Text(
                                  ageRangeToText(age),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ageRange = age;
                                  });
                                },
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: MainButton(
                        title: "Apply",
                        textColor: context.theme.textColor2,
                        backgroundColor: context.theme.buttonColor1,
                        removePadding: true,
                        onPressed: () {
                          BlocProvider.of<SearchBloc>(context).add(
                            SearchBook(
                              options: FilterOptions(
                                sortingMethod: sortingMethod,
                                startPrice: startPrice,
                                endPrice: endPrice,
                                ratingRange: ratingRange,
                                categories: searchCategories.entries
                                    .where((element) => element.value)
                                    .map((e) => e.key)
                                    .toList(),
                                language: filterLanguage,
                                ageRange: ageRange,
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MainFlatButton(
                        title: "Reset",
                        removePadding: true,
                        textColor: context.theme.textColor3,
                        backgroundColor: context.theme.buttonColor2,
                        onPressed: resetFilter,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }

  void loadSubCategories(List<String>? categoriesIds) {
    searchCategories.clear();
    if (categoriesIds != null) {
      if (categoriesIds.isNotEmpty) {
        for (var element in allCategories) {
          searchCategories.putIfAbsent(
            element,
            () => categoriesIds.contains(element.id),
          );
        }
      }
    }

    if (searchCategories.isEmpty) {
      for (var element in allCategories) {
        searchCategories.putIfAbsent(element, () => false);
      }
    }
  }

  void resetFilter() {
    setState(() {
      sortingMethod = SortingMethod.trending;
      startPrice = 4;
      endPrice = 32;
      ratingRange = RatingRange.all;
      loadSubCategories(null);
      filterLanguage = Language.all;
      ageRange = AgeRange.all;
    });
  }
}
