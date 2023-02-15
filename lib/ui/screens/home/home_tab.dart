import 'package:bibliotheque/blocs/categories_bloc.dart';
import 'package:bibliotheque/blocs/popular_books_bloc.dart';
import 'package:bibliotheque/blocs/recommended_books_bloc.dart';
import 'package:bibliotheque/blocs/unread_notifications_bloc.dart';
import 'package:bibliotheque/blocs/wish_list_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/screens/categories/categories_list_screen.dart';
import 'package:bibliotheque/ui/screens/home/home_screen.dart';
import 'package:bibliotheque/ui/screens/notifications/notifications_icon_button.dart';
import 'package:bibliotheque/ui/widgets/books_list_page.dart';
import 'package:bibliotheque/ui/widgets/category_card.dart';
import 'package:bibliotheque/ui/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/books_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bibliotheque'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          BlocProvider(
            create: (_) => UnreadNotificationsBloc(),
            child: const NotificationsIconButton(),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          BlocProvider(
            create: (_) => PopularBooksBloc()..add(LoadPopularBooks()),
            child: _PopularBooksContainer(
              onPopularClicked: () {
                if (globalHomeScreenKey.currentState != null) {
                  globalHomeScreenKey.currentState!.gotoPopular();
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          BlocProvider(
            create: (_) => CategoriesBloc()
              ..add(
                LoadCategories(allCategories: false),
              ),
            child: _CategoriesContainer(),
          ),
          const SizedBox(height: 20),
          BlocProvider(
            create: (_) => RecommendedBooksBloc()..add(LoadRecommendedBooks()),
            child: _RecommendedBooksContainer(),
          ),
          const SizedBox(height: 20),
          BlocProvider(
            create: (_) => WishListBloc()..add(LoadWishList()),
            child: _WishListContainer(
              onWishListClicked: () {
                if (globalHomeScreenKey.currentState != null) {
                  globalHomeScreenKey.currentState!.gotoWishList();
                }
              },
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _PopularBooksContainer extends StatelessWidget {
  final void Function() onPopularClicked;

  const _PopularBooksContainer({Key? key, required this.onPopularClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBooksBloc, PopularBooksState>(
      builder: (context, state) {
        if (state.status == PopularBooksStatus.loading) {
          return const Center(child: AppProgressIndicator(size: 100));
        }

        if (state.status == PopularBooksStatus.error) {
          return TryAgainWidget(onPressed: () {
            BlocProvider.of<PopularBooksBloc>(context).add(LoadPopularBooks());
          });
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Top charts'),
                  IconButton(
                    icon: const Icon(Icons.arrow_right_alt),
                    onPressed: onPopularClicked,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: state.books!.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: BookCard(book: state.books![index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoriesContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state.status == CategoriesStatus.loading) {
          return const Center(child: AppProgressIndicator(size: 100));
        }

        if (state.status == CategoriesStatus.error) {
          return TryAgainWidget(
            onPressed: () {
              BlocProvider.of<CategoriesBloc>(context).add(
                LoadCategories(allCategories: false),
              );
            },
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Explore by Genre'),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => CategoriesBloc()
                              ..add(
                                LoadCategories(
                                  allCategories: true,
                                ),
                              ),
                            child: const CategoriesListScreen(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_right_alt),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: state.categories!.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: CategoryCard(category: state.categories![index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RecommendedBooksContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedBooksBloc, RecommendedBooksState>(
      builder: (context, state) {
        if (state.status == RecommendedBooksStatus.loading) {
          return const Center(child: AppProgressIndicator(size: 100));
        }

        if (state.status == RecommendedBooksStatus.error) {
          return TryAgainWidget(onPressed: () {
            BlocProvider.of<RecommendedBooksBloc>(context)
                .add(LoadRecommendedBooks());
          });
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recommended for you'),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BooksListPage(
                              title: "Recommended for you",
                              booksSource: BooksSource.recommended,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_right_alt)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: state.books!.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: BookCard(book: state.books![index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _WishListContainer extends StatelessWidget {
  final void Function() onWishListClicked;

  const _WishListContainer({Key? key, required this.onWishListClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListBloc, WishListState>(
      builder: (context, state) {
        if (state.status == WishListStatus.loading) {
          return const Center(child: AppProgressIndicator(size: 100));
        }

        if (state.status == WishListStatus.error) {
          return TryAgainWidget(onPressed: () {
            BlocProvider.of<WishListBloc>(context).add(LoadWishList());
          });
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Wish List'),
                  IconButton(
                    icon: const Icon(Icons.arrow_right_alt),
                    onPressed: onWishListClicked,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: state.books!.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: BookCard(book: state.books![index]),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
