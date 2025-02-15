import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

/// Custom text styles for the app
class AppTextStyles {
  static const double height = 1.2;

  static TextStyle base = GoogleFonts.getFont('Prompt');

  static TextStyle h1 = base.copyWith(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static TextStyle h2 = base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static TextStyle h3 = base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static TextStyle label = base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.labelColor,
    letterSpacing: 1,
  );

  static TextStyle p1 = base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static TextStyle p2 = base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle p3 = base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static TextStyle p4 = base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle p5 = base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle p6 = base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bold = base.copyWith(
    fontWeight: FontWeight.bold,
  );

  /// Add more [TextStyle]s below
}

extension TextStyleExtension on TextStyle {
  TextStyle boldWeight(FontWeight fontWeight) => copyWith(
        fontWeight: fontWeight,
      );

  TextStyle get bold => copyWith(
        fontWeight: FontWeight.bold,
      );

  TextStyle colored(Color color) => copyWith(
        color: color,
      );

  TextStyle fontS(double font) => copyWith(
        fontSize: font,
      );

  TextStyle wordSp(double wordSpace) => copyWith(
        wordSpacing: wordSpace,
      );
}
