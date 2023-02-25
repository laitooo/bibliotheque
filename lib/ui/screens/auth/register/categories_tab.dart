import 'package:bibliotheque/blocs/categories_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  var selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            "Choose your age",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Select age range for better content",
            style: TextStyle(
              fontSize: 14,
              color: context.theme.textColor5,
            ),
          ),
          const SizedBox(height: 25),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state.status == CategoriesStatus.loading) {
                return const Center(child: AppProgressIndicator(size: 100));
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

              return Expanded(
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: List.generate(state.categories!.length, (index) {
                      final category = state.categories![index];
                      return FilterItem(
                        name: category.name,
                        isSelected: selectedCategories.contains(category.id),
                        onClick: () {
                          setState(() {
                            if (selectedCategories.contains(category.id)) {
                              selectedCategories.remove(category.id);
                            } else {
                              selectedCategories.add(category.id);
                            }
                          });
                        },
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
