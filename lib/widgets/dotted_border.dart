import 'dart:ui';

import 'package:flutter/material.dart';

// Border types for DottedBorder
enum BorderType { rReact, rect, circle }

/// Custom DottedBorder for screenshot upload
class DottedBorder extends StatelessWidget {
  final Widget child;
  final BorderType borderType;
  final double strokeWidth;
  final Color color;
  final List<double> dashPattern;
  final Radius radius;
  final EdgeInsets padding;

  const DottedBorder({
    super.key,
    required this.child,
    this.borderType = BorderType.rReact,
    this.strokeWidth = 1,
    this.color = Colors.black,
    this.dashPattern = const [5, 5],
    this.radius = const Radius.circular(0),
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        borderType: borderType,
        strokeWidth: strokeWidth,
        color: color,
        dashPattern: dashPattern,
        radius: radius,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final BorderType borderType;
  final double strokeWidth;
  final Color color;
  final List<double> dashPattern;
  final Radius radius;

  _DottedBorderPainter({
    required this.borderType,
    required this.strokeWidth,
    required this.color,
    required this.dashPattern,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    switch (borderType) {
      case BorderType.rReact:
        path.addRRect(RRect.fromRectAndRadius(Offset.zero & size, radius));
        break;
      case BorderType.rect:
        path.addRect(Offset.zero & size);
        break;
      case BorderType.circle:
        path.addOval(Offset.zero & size);
        break;
    }

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(_dashPath(path, dashPattern), paint);
  }

  Path _dashPath(Path originalPath, List<double> dashArray) {
    final Path dashedPath = Path();
    double currentLength = 0.0;
    final PathMetrics metrics = originalPath.computeMetrics();

    for (final PathMetric metric in metrics) {
      double start = 0.0;
      while (start < metric.length) {
        double end =
            start + dashArray[currentLength.toInt() % dashArray.length];
        dashedPath.addPath(metric.extractPath(start, end), Offset.zero);
        start = end + dashArray[(currentLength + 1).toInt() % dashArray.length];
        currentLength++;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant _DottedBorderPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.dashPattern != dashPattern ||
        oldDelegate.radius != radius ||
        oldDelegate.borderType != borderType;
  }
}
