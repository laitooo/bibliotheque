import 'package:bibliotheque/blocs/wish_list_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/no_data_page.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WishListBloc()..add(LoadWishList(true)),
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
        title: const Text("Wish List"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<WishListBloc, WishListState>(
        builder: (context, state) {
          if (state.status == WishListStatus.loading) {
            return const Center(child: AppProgressIndicator(size: 100));
          }

          if (state.status == WishListStatus.error) {
            return TryAgainWidget(
              onPressed: () {
                BlocProvider.of<WishListBloc>(context).add(LoadWishList(true));
              },
            );
          }

          if (state.books!.isEmpty) {
            return NoDataPage(
              text: 'Empty',
              subText: 'Add books to your wish list',
              icon: SvgPicture.asset(
                'assets/images/no_notifications.svg',
                width: 300,
                height: 200,
              ),
            );
          }

          return ListView(
            children: state.books!
                .map(
                  (book) => HorizontalBookCard(
                    book: book,
                    isWishList: true,
                    onRemoveClicked: () {
                      BlocProvider.of<WishListBloc>(context).add(
                        RemoveFromWishList(book.id),
                      );
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
