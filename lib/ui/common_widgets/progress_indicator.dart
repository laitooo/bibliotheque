import 'dart:math' as math;
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

class AppProgressIndicator extends StatefulWidget {
  final double size;
  final Color? color;

  const AppProgressIndicator({Key? key, this.size = 64, this.color})
      : super(key: key);

  @override
  _AppProgressIndicatorState createState() => _AppProgressIndicatorState();
}

class _AppProgressIndicatorState extends State<AppProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
        animation: controller,
        builder: (context, _) => CustomPaint(
          size: constraints.constrain(Size.square(widget.size)),
          painter: _AppProgressPainter(
            controller.value,
            widget.color ?? context.theme.primaryColor,
          ),
        ),
      );
    });
  }
}

class _AppProgressPainter extends CustomPainter {
  final double animation;
  final Color color;

  _AppProgressPainter(this.animation, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final current = animation * 8;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // move canvas origin to center
    canvas.translate(size.width / 2, size.height / 2);
    final degreeZeroRRectCenter =
        Offset(size.width / 2 - size.width / 5.0, 0.0);
    for (int i = 0; i < 8; ++i) {
      paint.color = color.withOpacity(
        dist(current, i) / 4,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: degreeZeroRRectCenter,
              width: size.width / 5.0,
              height: size.height / 12.0),
          const Radius.circular(5.0),
        ),
        paint,
      );
      canvas.rotate(2 * math.pi / 8.0);
    }
  }

  double dist(double current, int i) {
    double res = (current - i).abs();
    if (res > 4) {
      res = 8 - res;
    }
    return res;
  }

  @override
  bool shouldRepaint(_AppProgressPainter old) => true;
}
