import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'app_colors.dart';

class WavyProgressPainter extends CustomPainter {
  final double progress;

  WavyProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = const Color(0xFF4A4A5A)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final progressPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final centerY = size.height / 2;
    final waveAmplitude = 2.0;
    final waveFrequency = 13.0;
    final clampedProgress = progress.clamp(0.0, 1.0);
    final progressWidth = size.width * clampedProgress;

    final backgroundPath = Path();
    backgroundPath.moveTo(0, centerY);

    for (double x = 0; x <= size.width; x += 0.5) {
      final y =
          centerY +
          waveAmplitude *
              math.sin(2 * math.pi * waveFrequency * x / size.width);
      backgroundPath.lineTo(x, y);
    }

    final progressPath = Path();
    if (progressWidth > 0) {
      progressPath.moveTo(0, centerY);

      for (double x = 0; x <= progressWidth; x += 0.5) {
        final y =
            centerY +
            waveAmplitude *
                math.sin(2 * math.pi * waveFrequency * x / size.width);
        progressPath.lineTo(x, y);
      }
    }

    canvas.drawPath(backgroundPath, backgroundPaint);

    if (progressWidth > 0) {
      canvas.drawPath(progressPath, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is WavyProgressPainter) {
      return oldDelegate.progress != progress;
    }
    return true;
  }
}
