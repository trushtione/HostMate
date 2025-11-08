import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Font Family
  static const String fontFamily = 'Space Grotesk';

  static TextStyle get headingH1Bold => GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 36 / 28,
    letterSpacing: 28 * -0.03,
    color: Colors.white,
  );

  static TextStyle get headingH1Regular => GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w200,
    height: 36 / 28,
    letterSpacing: 28 * -0.03,
    color: Colors.white,
  );
  static TextStyle get headingH2Bold => GoogleFonts.spaceGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 30 / 24,
    letterSpacing: 24 * -0.02,
    color: Colors.white,
  );

  static TextStyle get headingH2Regular => GoogleFonts.spaceGrotesk(
    fontSize: 24,
    fontWeight: FontWeight.w200,
    height: 30 / 24,
    letterSpacing: 24 * -0.02,
    color: Colors.white,
  );

  static TextStyle get headingH3Bold => GoogleFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 26 / 20,
    letterSpacing: 20 * -0.01,
    color: Colors.white,
  );

  static TextStyle get headingH3Regular => GoogleFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w200,
    height: 26 / 20,
    letterSpacing: 20 * -0.01,
    color: Colors.white,
  );
  static TextStyle get bodyB1Bold => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0.0,
    color: Colors.white,
  );

  static TextStyle get bodyB1Regular => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w200,
    height: 24 / 16,
    letterSpacing: 0.0,
    color: Colors.white,
  );

  static TextStyle get bodyB2Bold => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.0,
    color: Colors.white,
  );

  static TextStyle get bodyB2Regular => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w200,
    height: 20 / 14,
    letterSpacing: 0.0,
    color: Colors.white,
  );

  static TextStyle get subtextS1Bold => GoogleFonts.spaceGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    height: 16 / 12,
    letterSpacing: 0.0,
    color: Colors.white,
  );

  static TextStyle get subtextS1Regular => GoogleFonts.spaceGrotesk(
    fontSize: 12,
    fontWeight: FontWeight.w200,
    height: 16 / 12,
    letterSpacing: 0.0,
    color: Colors.white,
  );

  static TextStyle get subtextS2 => GoogleFonts.spaceGrotesk(
    fontSize: 10,
    fontWeight: FontWeight.w200,
    height: 12 / 10,
    letterSpacing: 0.0,
    color: Colors.white,
  );

  static TextStyle get stepIndicator => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0,
    color: Colors.grey[400]!,
  );

  static TextStyle get questionHeading => GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: 0,
    color: Colors.white,
  );

  static TextStyle get description => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0,
    color: Colors.grey[400]!,
  );

  static TextStyle get buttonText => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0,
    color: Colors.white,
  );

  static TextStyle get inputText => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
    color: Colors.white,
  );

  static TextStyle get inputPlaceholder => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
    color: Colors.grey[500]!,
  );

  static TextStyle get cardTitle => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.0,
    letterSpacing: 1.2,
    color: Colors.white,
  );

  static TextStyle get recordingTitle => GoogleFonts.spaceGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0,
    color: Colors.white,
  );

  static TextStyle get recordingDuration => GoogleFonts.spaceGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: 0,
    color: Colors.grey[400]!,
  );
}
