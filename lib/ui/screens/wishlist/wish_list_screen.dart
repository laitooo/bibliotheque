import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/cubits/wish_list_cubit.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/app_snackbar.dart';
import 'package:bibliotheque/ui/common_widgets/try_again_widget.dart';
import 'package:bibliotheque/ui/common_widgets/empty_list_widget.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/search/filter_screen.dart';
import 'package:bibliotheque/ui/screens/settings/about_app_screen.dart';
import 'package:bibliotheque/ui/widgets/book_card.dart';
import 'package:bibliotheque/ui/widgets/search_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WishListCubit()..loadWishList(true),
      child: const _WishListScreen(),
    );
  }
}

class _WishListScreen extends StatefulWidget {
  const _WishListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<_WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<_WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.wishlist.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: context.theme.textColor1,
          ),
        ),
        centerTitle: false,
        actions: [
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
          const SearchIcon(),
        ],
      ),
      body: BlocConsumer<WishListCubit, WishListState>(
        listener: (context, state) {
          if (state is WishListError) {
            context.showSnackBar(text: t.errors.errorRemovingTryAgain);
          }
        },
        builder: (context, state) {
          if (state is WishListLoading) {
            return const Center(child: AppProgressIndicator(size: 100));
          }

          if (state is WishListError) {
            return TryAgainWidget(
              onPressed: () {
                BlocProvider.of<WishListCubit>(context).loadWishList(true);
              },
            );
          }

          if ((state as WishListLoaded).books.isEmpty) {
            return EmptyListWidget(
              text: t.wishlist.empty,
              subText: t.wishlist.addBooks,
              isPage: false,
            );
          }

          return ListView(
            children: state.books
                .map(
                  (book) => WishListCard(
                    book: book,
                    onItemClicked: (index) {
                      switch (index) {
                        case 0:
                          BlocProvider.of<WishListCubit>(context)
                              .removeFromWishList(book.id);
                          break;
                        case 2:
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AboutAppScreen(),
                            ),
                          );
                          break;
                        case 1:
                        default:
                          break;
                      }
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
