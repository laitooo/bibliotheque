import 'package:bibliotheque/blocs/books_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/category.dart';
import 'package:bibliotheque/ui/common_widgets/mockable_image.dart';
import 'package:bibliotheque/ui/widgets/books_list_page.dart';
import 'package:bibliotheque/utils/locale_based_string_selector.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BooksListPage(
                  title: LocaleBasedStringSelector.select(
                    context,
                    category.nameAr,
                    category.nameEn,
                  ),
                  categoryId: category.id,
                  booksSource: BooksSource.category,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 120,
              width: 200,
              child: MockableImage(
                category.imageUrl,
                fit: BoxFit.cover,
                type: MockImageType.category,
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 6,
          start: 10,
          child: Text(
            LocaleBasedStringSelector.select(
              context,
              category.nameAr,
              category.nameEn,
            ),
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: context.theme.textColor2,
            ),
          ),
        ),
      ],
    );
  }
}
