import 'package:bibliotheque/blocs/categories_bloc.dart';
import 'package:bibliotheque/blocs/register_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
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
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              t.auth.register.chooseBookGenre,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: context.theme.textColor1,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              t.auth.register.selectBookGenre,
              style: TextStyle(
                fontSize: 14,
                color: context.theme.textColor4,
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
                      children:
                          List.generate(state.categories!.length, (index) {
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: MainButton(
                title: t.auth.register.continu,
                textColor: context.theme.textColor2,
                backgroundColor: context.theme.buttonColor1,
                removePadding: true,
                onPressed: () async {
                  BlocProvider.of<RegisterBloc>(context).add(
                    InputFavouriteCategories(
                      categoriesIds: selectedCategories,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: MainFlatButton(
                title: t.auth.register.skip,
                removePadding: true,
                onPressed: () {
                  BlocProvider.of<RegisterBloc>(context).add(
                    InputFavouriteCategories(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
