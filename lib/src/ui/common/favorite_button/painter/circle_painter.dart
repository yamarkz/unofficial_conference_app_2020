import 'package:flutter/material.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/favorite_button/utils/favorite_button_model.dart';
import 'package:unofficial_conference_app_2020/src/ui/common/favorite_button/utils/favorite_button_util.dart';

class CirclePainter extends CustomPainter {
  Paint circlePaint = Paint();

  final double outerCircleRadiusProgress;
  final double innerCircleRadiusProgress;
  final CircleColor circleColor;

  CirclePainter({
    @required this.outerCircleRadiusProgress,
    @required this.innerCircleRadiusProgress,
    this.circleColor = const CircleColor(
      start: Color(0xFFFF5722),
      end: Color(0xFFFFC107),
    ),
  }) {
    circlePaint..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width * 0.5;
    _updateCircleColor();
    final strokeWidth = outerCircleRadiusProgress * center -
        (innerCircleRadiusProgress * center);
    if (strokeWidth > 0.0) {
      circlePaint..strokeWidth = strokeWidth;
      canvas.drawCircle(Offset(center, center),
          outerCircleRadiusProgress * center, circlePaint);
    }
  }

  void _updateCircleColor() {
    var colorProgress = clamp(outerCircleRadiusProgress, 0.5, 1.0);
    colorProgress = mapValueFromRangeToRange(colorProgress, 0.5, 1.0, 0.0, 1.0);
    circlePaint
      ..color = Color.lerp(circleColor.start, circleColor.end, colorProgress);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate.runtimeType != runtimeType) return true;
    final CirclePainter old = oldDelegate;

    return old.outerCircleRadiusProgress != old.outerCircleRadiusProgress ||
        old.innerCircleRadiusProgress != old.innerCircleRadiusProgress ||
        old.circleColor != old.circleColor;
  }
}
