import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final bool isVisible;
  final String svgPath;
  final Function() onPressed;

  const AppIconButton({
    Key? key,
    this.isVisible = true,
    required this.svgPath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? Container(
            width: 45,
            height: 45,
            margin: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 20),
            decoration: BoxDecoration(
              color: context.theme.iconBackgroundColor,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                width: 2,
                color: context.theme.borderColor,
              ),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Center(
                child: Svg(
                  svgPath,
                  size: 20,
                  color: context.theme.iconColor,
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
