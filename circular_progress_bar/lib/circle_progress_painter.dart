import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color backgroundLineColor;
  final Color progressLineColor;
  final double linesMargin;
  final double backgroundLineWidth;
  final double lineWidth;

  CircleProgressPainter({
    this.percent = 0.4,
    this.backgroundLineWidth = 7,
    this.lineWidth = 7,
    this.linesMargin = 5,
    this.fillColor = Colors.black,
    this.progressLineColor = Colors.yellow,
    Color? backgroundLineColor,
  }) : backgroundLineColor =
            backgroundLineColor ?? Colors.grey.withOpacity(0.6);

  @override
  void paint(Canvas canvas, Size size) {
    final arcRect = calculateArcRect(size);
    drawBackground(canvas, size);
    drawFilledArc(canvas, arcRect);
    drawFreeArc(canvas, arcRect);
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint();
    paint
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  void drawFilledArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint
      ..color = backgroundLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = backgroundLineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      arcRect,
      0,
      pi * 2,
      false,
      paint,
    );
  }

  void drawFreeArc(Canvas canvas, Rect arcRect) {
    final paint = Paint();
    paint
      ..color = progressLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      arcRect,
      -pi / 2,
      pi * 2 * percent,
      false,
      paint,
    );
  }

  Rect calculateArcRect(Size size) {
    final offset = lineWidth / 2 + linesMargin;
    return Offset(offset, offset) &
        Size(
          size.width - offset * 2,
          size.height - offset * 2,
        );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
