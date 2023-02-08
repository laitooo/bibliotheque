import 'package:bibliotheque/blocs/theme.dart';
import 'package:bibliotheque/models/category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              height: 120,
              width: 200,
              child: Image(
                image: NetworkImage(category.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 6,
          start: 10,
          child: Text(
            category.name,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              color: context.theme.cardColor,
            ),
          ),
        ),
      ],
    );
  }
}
