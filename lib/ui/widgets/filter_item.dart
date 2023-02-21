import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String name;
  final Widget? icon;
  final bool isSelected;
  final Function() onClick;

  const FilterItem(
      {Key? key,
      required this.name,
      this.icon,
      required this.isSelected,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? context.theme.filterItemColor1
              : context.theme.filterItemColor2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: context.theme.filterItemColor1,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 6),
            ],
            Text(
              name,
              style: TextStyle(
                color: isSelected
                    ? context.theme.filterItemColor2
                    : context.theme.filterItemColor1,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
