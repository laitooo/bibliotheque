import 'package:bibliotheque/blocs/categories.dart';
import 'package:bibliotheque/blocs/popular_books.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/category_card.dart';
import 'package:bibliotheque/ui/widgets/popular_book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        centerTitle: false,
        actions: const [
          Icon(Icons.search),
        ],
      ),
      body: ListView(
        children: [
          BlocProvider(
            create: (_) => PopularBooksBloc()..add(LoadPopularBooks()),
            child: _PopularBooksContainer(),
          ),
          const SizedBox(height: 20),
          BlocProvider(
            create: (_) => CategoriesBloc()..add(LoadCategories()),
            child: _CategoriesContainer(),
          ),
        ],
      ),
    );
  }
}

class _PopularBooksContainer extends StatelessWidget {
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
                children: const [
                  Text('Top charts'),
                  Icon(Icons.arrow_right_alt),
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
                    child: PopularBookCard(book: state.books![index]),
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
          return TryAgainWidget(onPressed: () {
            BlocProvider.of<CategoriesBloc>(context).add(LoadCategories());
          });
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Explore by Genre'),
                  Icon(Icons.arrow_right_alt),
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
