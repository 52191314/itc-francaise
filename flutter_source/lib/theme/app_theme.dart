import 'package:flutter/material.dart';

/// Design tokens matching the web app's CSS variables.
/// Dark:  bg #0f1729 · card rgba(22,33,62,0.9) · accent #22d3a7
/// Light: bg #f0f4f8 · card #ffffff              · accent #0d9977
class AppTheme {
  AppTheme._();

  // ── Shared colour constants ──────────────────────────────────
  static const Color accentDark = Color(0xFF22D3A7);
  static const Color accentLight = Color(0xFF08745B);
  static const Color gold = Color(0xFFF0B936);
  static const Color coral = Color(0xFFF07056);
  static const Color blue = Color(0xFF5B8DEF);
  static const Color purple = Color(0xFFA78BFA);

  // Dark background palette
  static const Color bgDark = Color(0xFF0F1729);
  static const Color surfaceDark = Color(0xFF16213E);
  static const Color cardDark = Color(0xFF1A2744);

  // Light background palette
  static const Color bgLight = Color(0xFFF0F4F8);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFF8FAFC);

  static const double radius = 14;
  static const double radiusSm = 10;
  static const double radiusXs = 7;

  // ── Dark theme ───────────────────────────────────────────────
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      colorScheme: const ColorScheme.dark(
        primary: accentDark,
        secondary: blue,
        tertiary: gold,
        surface: surfaceDark,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Color(0xFFE8ECF4),
        error: coral,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceDark,
        foregroundColor: Color(0xFFE8ECF4),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFFE8ECF4),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: surfaceDark,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.07)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF0F1729).withValues(alpha: 0.85),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: accentDark, width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFF5A6478)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF16213E),
        selectedColor: accentDark.withValues(alpha: 0.2),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: accentDark),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accentDark,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusSm)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.white.withValues(alpha: 0.07),
        thickness: 1,
      ),
      textTheme:
          _buildTextTheme(const Color(0xFFE8ECF4), const Color(0xFF8892A8)),
    );
  }

  // ── Light theme ──────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: bgLight,
      colorScheme: const ColorScheme.light(
        primary: accentLight,
        secondary: Color(0xFF3B6DD9),
        tertiary: Color(0xFFC48A0A),
        surface: surfaceLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1A202C),
        error: Color(0xFFC0392B),
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceLight,
        foregroundColor: Color(0xFF1A202C),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A202C),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: surfaceLight,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: cardLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.07)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusSm),
          borderSide: const BorderSide(color: accentLight, width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFF64748B)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: accentLight.withValues(alpha: 0.12),
        side: BorderSide(color: Colors.black.withValues(alpha: 0.08)),
        labelStyle: const TextStyle(
          color: Color(0xFF1A202C),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        secondaryLabelStyle: const TextStyle(
          color: accentLight,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF334155)),
      listTileTheme: const ListTileThemeData(
        textColor: Color(0xFF1A202C),
        iconColor: Color(0xFF475569),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        textColor: Color(0xFF1A202C),
        collapsedTextColor: Color(0xFF1A202C),
        iconColor: accentLight,
        collapsedIconColor: Color(0xFF475569),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: accentLight),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentLight,
          side: const BorderSide(color: accentLight),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accentLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusSm)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.black.withValues(alpha: 0.07),
        thickness: 1,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentLight,
        selectionColor: accentLight.withValues(alpha: 0.24),
        selectionHandleColor: accentLight,
      ),
      textTheme:
          _buildTextTheme(const Color(0xFF111827), const Color(0xFF475569)),
    );
  }

  static TextTheme _buildTextTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w800, color: primary),
      displayMedium: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w700, color: primary),
      headlineLarge: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w700, color: primary),
      headlineMedium: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w600, color: primary),
      titleLarge: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w700, color: primary),
      titleMedium: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w600, color: primary),
      titleSmall: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w600, color: secondary),
      bodyLarge: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w400, color: primary),
      bodyMedium: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w400, color: primary),
      bodySmall: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w400, color: secondary),
      labelLarge: TextStyle(
          fontFamily: 'Inter', fontWeight: FontWeight.w600, color: primary),
      labelSmall: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          color: secondary,
          letterSpacing: 0.5),
    );
  }
}
