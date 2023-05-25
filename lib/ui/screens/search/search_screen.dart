import 'package:bibliotheque/blocs/categories_bloc.dart';
import 'package:bibliotheque/blocs/search_bloc.dart';
import 'package:bibliotheque/blocs/search_history_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/app_snackbar.dart';
import 'package:bibliotheque/ui/common_widgets/try_again_widget.dart';
import 'package:bibliotheque/ui/common_widgets/empty_list_widget.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/screens/search/filter_screen.dart';
import 'package:bibliotheque/ui/widgets/book_card.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isGrid = true;
  final _textFieldFocus = FocusNode();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textFieldFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (searchController.text.isEmpty) {
            return true;
          } else {
            searchController.text = "";
            BlocProvider.of<SearchBloc>(context).add(
              ClearSearchResults(),
            );
            return false;
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Svg('back.svg'),
                  ),
                  Flexible(
                    flex: 1,
                    child: _searchField(),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.status == SearchStatus.idle) {
                      return BlocConsumer<SearchHistoryBloc,
                          SearchHistoryState>(
                        listener: (_, historyState) {
                          if (historyState.status ==
                              SearchHistoryStatus.error) {
                            if (historyState.error ==
                                SearchHistoryError.clearingError) {
                              context.showSnackBar(
                                text: t.errors.errorClearingTryAgain,
                              );
                            }

                            if (historyState.error ==
                                SearchHistoryError.removingError) {
                              context.showSnackBar(
                                text: t.errors.errorRemovingTryAgain,
                              );
                            }
                          }
                        },
                        builder: (_, historyState) {
                          if (historyState.status ==
                              SearchHistoryStatus.loading) {
                            return const Center(
                              child: AppProgressIndicator(size: 100),
                            );
                          }

                          if (historyState.status == SearchStatus.error &&
                              historyState.error ==
                                  SearchHistoryError.loadingError) {
                            return Center(
                              child: Text(
                                t.search.startSearching,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: context.theme.textColor1,
                                ),
                              ),
                            );
                          }
                          return ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      t.search.searchHistory,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: context.theme.textColor1,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<SearchHistoryBloc>(
                                                context)
                                            .add(ClearSearchHistory());
                                      },
                                      icon: const Svg(
                                        "close.svg",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              ...List.generate(historyState.list!.length,
                                  (index) {
                                return InkWell(
                                  onTap: () {
                                    searchController.text =
                                        historyState.list![index];
                                    BlocProvider.of<SearchBloc>(context).add(
                                      SearchBook(
                                        query: historyState.list![index],
                                      ),
                                    );
                                  },
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              historyState.list![index],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: context.theme.textColor1,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              BlocProvider.of<
                                                          SearchHistoryBloc>(
                                                      context)
                                                  .add(
                                                RemovePreviousSearch(
                                                  historyState.list![index],
                                                ),
                                              );
                                            },
                                            icon: const Svg(
                                              "close.svg",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          );
                        },
                      );
                    }

                    if (state.status == SearchStatus.loading) {
                      return const Center(
                          child: AppProgressIndicator(size: 100));
                    }

                    if (state.status == SearchStatus.error) {
                      return TryAgainWidget(
                        onPressed: () {
                          BlocProvider.of<SearchBloc>(context).add(
                            SearchBook(
                              query: searchController.text,
                            ),
                          );
                        },
                      );
                    }

                    if (state.books!.isEmpty) {
                      return EmptyListWidget(
                        text: t.search.empty,
                        subText: t.search.noResults,
                        isPage: false,
                      );
                    }

                    if (isGrid) {
                      return Column(
                        children: [
                          showMethod(),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                              mainAxisSpacing: 10,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              children: state.books!
                                  .map(
                                    (book) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: BookCard(book: book),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ListView(
                        children: [
                          showMethod(),
                          ...state.books!
                              .map(
                                (book) => HorizontalBookCard(
                                  book: book,
                                ),
                              )
                              .toList(),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMethod() {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          t.search.showIn,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.theme.textColor1,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            setState(() {
              isGrid = true;
            });
          },
          icon: Svg(
            'grid_view.svg',
            color: isGrid
                ? context.theme.activeColor
                : context.theme.inActiveColor,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isGrid = false;
            });
          },
          icon: Svg(
            'menu.svg',
            color: isGrid
                ? context.theme.inActiveColor
                : context.theme.activeColor,
          ),
        ),
      ],
    );
  }

  _searchField() {
    return SizedBox(
      child: TextField(
        focusNode: _textFieldFocus,
        controller: searchController,
        textInputAction: TextInputAction.search,
        maxLength: 50,
        onSubmitted: (value) {
          if (searchController.text.isNotEmpty) {
            BlocProvider.of<SearchHistoryBloc>(context).add(
              AddPreviousSearch(searchController.text),
            );
          }
          BlocProvider.of<SearchBloc>(context).add(
            SearchBook(
              query: value,
            ),
          );
        },
        style: TextStyle(
          fontSize: 18,
          color: context.theme.textColor1,
        ),
        decoration: InputDecoration(
          counter: const SizedBox(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: context.theme.primaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Svg(
              "search.svg",
              // size: 16,
              color: context.theme.iconColor1,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 24,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<SearchBloc>(context),
                      ),
                      BlocProvider(
                        create: (_) => CategoriesBloc()
                          ..add(LoadCategories(allCategories: true)),
                      ),
                    ],
                    child: const FilterScreen(),
                  ),
                ),
              );
            },
            icon: Svg(
              'filter.svg',
              color: context.theme.primaryColor,
            ),
          ),
          filled: true,
          fillColor: _textFieldFocus.hasFocus
              ? context.theme.primaryColor.withOpacity(0.1)
              : context.theme.inActiveColor.withOpacity(0.2),
        ),
      ),
    );
  }
}
