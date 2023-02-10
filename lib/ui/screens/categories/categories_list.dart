import 'package:bibliotheque/blocs/categories.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesListScreen extends StatelessWidget {
  const CategoriesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore by Genre'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state.status == CategoriesStatus.loading) {
            return const Center(child: AppProgressIndicator(size: 100));
          }

          if (state.status == CategoriesStatus.error) {
            return TryAgainWidget(
              onPressed: () {
                BlocProvider.of<CategoriesBloc>(context).add(
                  LoadCategories(
                    allCategories: true,
                  ),
                );
              },
            );
          }

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: state.categories!
                .map(
                  (category) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: CategoryCard(category: category),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
