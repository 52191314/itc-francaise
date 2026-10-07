import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  static const String fontFamilyHeader = 'Playfair Display';
  static const String fontFamilyBody = 'Inter';

  static const TextStyle headerTitle = TextStyle(
    fontFamily: fontFamilyHeader,
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headword = TextStyle(
    fontFamily: fontFamilyHeader,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14.0,
    color: AppColors.textMuted,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 15.0,
    color: AppColors.textSecondary,
  );
}
