import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_text_style.dart';
import 'app_assets.dart';
import 'app_strings.dart';
import 'app_colors.dart';
import 'responsive.dart';

class CommonNextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isExpanded;

  const CommonNextButton({
    super.key,
    required this.onPressed,
    this.isEnabled = false,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: Responsive.getSpacing(context, 56),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Responsive.getSpacing(context, 8),
            ),
            gradient: isEnabled
                ? RadialGradient(
                    center: Alignment.center,
                    radius: 1.0,
                    colors: [
                      const Color(0xFF222222),
                      const Color(0xFF999999),
                      const Color(0xFF222222),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  )
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xFF2A2A2A), const Color(0xFF1A1A1A)],
                  ),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (isEnabled)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              if (isEnabled)
                Positioned.fill(
                  child: CustomPaint(painter: GradientBorderPainter()),
                ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.getHorizontalPadding(context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.next,
                        style: AppTextStyles.bodyB1Bold.copyWith(
                          color: isEnabled ? AppColors.text1 : AppColors.text4,
                          fontSize: Responsive.getFontSize(context, 16),
                        ),
                      ),
                      SizedBox(width: Responsive.getSpacing(context, 8)),
                      SvgPicture.asset(
                        AppAssets.vector,
                        width: Responsive.getFontSize(context, 16),
                        height: Responsive.getFontSize(context, 16),
                        alignment: Alignment.center,
                        colorFilter: ColorFilter.mode(
                          isEnabled ? AppColors.text1 : AppColors.text4,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (isExpanded) {
      return Expanded(child: button);
    }

    return SizedBox(width: double.infinity, child: button);
  }
}

class GradientBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1),
      const Radius.circular(8),
    );

    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [const Color(0xFF101010), const Color(0xFFFFFFFF)],
    ).createShader(rect.outerRect);

    paint.shader = gradient;
    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
