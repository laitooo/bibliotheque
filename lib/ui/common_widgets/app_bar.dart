import 'package:bibliotheque/blocs/theme.dart';
import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: context.theme.primaryTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
      ),
      primary: true,
      leadingWidth: 80.0,
      leading: canPop
          ? IconButton(
              icon: Center(
                child: Container(
                  constraints: BoxConstraints.tight(const Size.square(32.0)),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.theme.borderColor),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsetsDirectional.only(start: 6.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 14,
                    color: context.theme.iconColor,
                  ),
                ),
              ),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () {
                Navigator.maybePop(context);
              },
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
