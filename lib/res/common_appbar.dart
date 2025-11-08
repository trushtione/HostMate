import 'package:flutter/material.dart';
import 'wavy_progress_painter.dart';
import 'responsive.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double progress;
  final VoidCallback? onBackPressed;
  final VoidCallback? onClosePressed;

  const CommonAppBar({
    super.key,
    required this.progress,
    this.onBackPressed,
    this.onClosePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF9B7EDE).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.getSpacing(context, 8),
            vertical: Responsive.getSpacing(context, 8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: Responsive.getFontSize(context, 24),
                ),
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),

              Expanded(
                child: Center(
                  child: CustomPaint(
                    size: Size(
                      Responsive.getFontSize(context, 200),
                      Responsive.getFontSize(context, 20),
                    ),
                    painter: WavyProgressPainter(progress: progress),
                  ),
                ),
              ),

              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: Responsive.getFontSize(context, 24),
                ),
                onPressed: onClosePressed ?? () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
