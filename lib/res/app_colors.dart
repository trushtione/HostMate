import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF9196FF);
  static const Color secondaryAccent = Color(0xFF5961FF);
  static const Color positive = Color(0xFFFE5BDB);
  static const Color negative = Color(0xFFC22743);
  static const Color text1 = Color(0xFFFFFFFF);
  static Color get text2 => text1.withValues(alpha: 0.72);
  static Color get text3 => text1.withValues(alpha: 0.48);
  static Color get text4 => text1.withValues(alpha: 0.24);
  static Color get text5 => text1.withValues(alpha: 0.24);
  static const Color base2 = Color(0xFF101010);
  static const Color base2Medium = Color(0xFF151515);
  static Color get surfaceWhite1 => text1.withValues(alpha: 0.02);
  static Color get surfaceWhite2 => text1.withValues(alpha: 0.05);
  static Color get surfaceBlack1 => base2.withValues(alpha: 0.90);
  static Color get surfaceBlack2 => base2.withValues(alpha: 0.70);
  static Color get surfaceBlack3 => base2.withValues(alpha: 0.50);
  static Color get border1 => text1.withValues(alpha: 0.08);
  static Color get border2 => text1.withValues(alpha: 0.16);
  static Color get border3 => text1.withValues(alpha: 0.24);
  static const Color appBarBackground = Color(0xFF1A1A1A);
  static const Color appBarBorder = Color(0xFF9B7EDE);
  static const Color progressBackground = Color(0xFF4A4A5A);
}
