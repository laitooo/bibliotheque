import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  final Function() onClick;

  const FilterItem(
      {Key? key,
      required this.name,
      required this.isSelected,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.filterItemColor1
              : context.theme.filterItemColor2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.theme.filterItemColor1,
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isSelected
                ? context.theme.filterItemColor2
                : context.theme.filterItemColor1,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
