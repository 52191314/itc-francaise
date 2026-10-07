import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bgApp,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.terracottaPrimary,
        primary: AppColors.terracottaPrimary,
        surface: AppColors.bgCard,
        surfaceContainer: AppColors.bgApp,
      ),
      cardTheme: CardThemeData(
        color: AppColors.bgCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgApp,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        titleTextStyle: AppTypography.headerTitle,
      ),
      fontFamily: AppTypography.fontFamilyBody,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.terracottaPrimary,
        brightness: Brightness.dark,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF2C2C2E),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }
}
