import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Svg extends StatelessWidget {
  final String path;
  final Color? color;
  final double? size;
  final bool? matchTextDirection;

  const Svg(this.path,
      {Key? key, this.color, this.size = 24, this.matchTextDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/" + path,
      width: size,
      height: size,
      matchTextDirection: matchTextDirection ?? true,
      color: color ?? context.theme.iconColor1,
    );
  }
}
