import 'package:flutter/material.dart';

class WaveformWidget extends StatelessWidget {
  final List<double> amplitudeData;
  final int barCount;

  const WaveformWidget({
    super.key,
    required this.amplitudeData,
    this.barCount = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(barCount, (index) {
          double targetHeight;

          if (amplitudeData.isNotEmpty && amplitudeData.length >= barCount) {
            final amplitude =
                amplitudeData[index.clamp(0, amplitudeData.length - 1)];
            targetHeight = 4.0 + (amplitude * 28.0);
          } else {
            final isTall = index % 2 == 0;
            final baseHeight = isTall ? 24.0 : 8.0;
            final variation = (index % 3) * 2.0;
            targetHeight = isTall
                ? baseHeight + variation
                : baseHeight - (variation * 0.5);
          }

          return Container(
            width: 4,
            height: targetHeight.clamp(4.0, 32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }
}
