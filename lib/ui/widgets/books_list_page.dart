import 'package:bibliotheque/blocs/books_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/search/filter_screen.dart';
import 'package:bibliotheque/ui/widgets/book_card.dart';
import 'package:bibliotheque/ui/widgets/search_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksListPage extends StatelessWidget {
  final String title;
  final String? categoryId;
  final BooksSource booksSource;

  const BooksListPage({
    Key? key,
    required this.title,
    required this.booksSource,
    this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = LoadBooks(booksSource);
    return BlocProvider(
      create: (_) => BooksBloc()..add(event),
      child: _BooksListPage(
        event: event,
        title: title,
      ),
    );
  }
}

class _BooksListPage extends StatefulWidget {
  final String title;
  final LoadBooks event;
  const _BooksListPage({
    Key? key,
    required this.title,
    required this.event,
  }) : super(key: key);

  @override
  State<_BooksListPage> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<_BooksListPage> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: context.theme.textColor1,
          ),
        ),
        centerTitle: false,
        actions: [
          const SearchIcon(),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FilterScreen(),
                ),
              );
            },
            icon: const Svg('filter.svg'),
          ),
        ],
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (state.status == BooksStatus.loading) {
            return const Center(child: AppProgressIndicator(size: 100));
          }

          if (state.status == BooksStatus.error) {
            return TryAgainWidget(
              onPressed: () {
                BlocProvider.of<BooksBloc>(context).add(widget.event);
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
                            padding: const EdgeInsets.symmetric(horizontal: 7),
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
}
