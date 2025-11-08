import 'package:flutter/material.dart';
import 'app_assets.dart';

class WavyBackground extends StatelessWidget {
  final Widget child;

  const WavyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
