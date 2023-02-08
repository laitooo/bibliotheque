import 'dart:math' as math;
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/material.dart';

class RotateIcon extends StatelessWidget {
  final Widget icon;
  const RotateIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(prefs.isArabic() ? 0 : math.pi),
      child: icon,
    );
  }
}
