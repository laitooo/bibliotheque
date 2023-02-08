import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Svg extends StatelessWidget {
  final String path;
  final Color? color;
  final double? size;
  final bool? matchTextDirection;

  const Svg(this.path,
      {Key? key, this.color, this.size, this.matchTextDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      matchTextDirection: matchTextDirection ?? false,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
