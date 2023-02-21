import 'package:bibliotheque/blocs/search_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
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
  String query = "";
  final _textFieldFocus = FocusNode();

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
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state.status == SearchStatus.error &&
              state.error == SearchError.invalidQuery) {
            // TODO: fix scaffold colors
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please enter a valid text"),
              ),
            );
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
                    icon: const Icon(Icons.arrow_back_rounded),
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
                      return const Center(child: Text("Start searching"));
                    }

                    if (state.status == SearchStatus.loading) {
                      return const Center(
                          child: AppProgressIndicator(size: 100));
                    }

                    if (state.status == SearchStatus.error &&
                        state.error == SearchError.networkError) {
                      return TryAgainWidget(
                        onPressed: () {
                          BlocProvider.of<SearchBloc>(context)
                              .add(SearchBook(query));
                        },
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
                                  isWishList: false,
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
          'Show in',
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
          icon: Icon(
            Icons.grid_view,
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
          icon: Icon(
            Icons.menu,
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
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          query = value;
          BlocProvider.of<SearchBloc>(context).add(SearchBook(value));
        },
        style: TextStyle(
          fontSize: 14,
          color: context.theme.textColor1,
        ),
        decoration: InputDecoration(
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
          prefixIcon: Icon(
            Icons.search,
            color: context.theme.iconColor1,
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_list,
              color: context.theme.iconColor1,
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
