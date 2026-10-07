import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ═══════════════════════════════════════════════════════════════
///  Atelier — French Pro 2.0 Design Language
///
///  A warm, editorial, tactile palette inspired by vintage
///  French notebooks, Parisian signage, and premium journal apps.
/// ═══════════════════════════════════════════════════════════════
class AppTheme {
  AppTheme._();

  // ── Atelier Color Palette ─────────────────────────────────────

  // Backgrounds
  static const Color parchment = Color(0xFFF7F5F0);
  static const Color deepInk = Color(0xFF0F1115);

  // Surfaces
  static const Color creamPaper = Color(0xE6FFFFFF); // white at 90%
  static const Color charcoal = Color(0xFF1A1D23);

  // Primary — Terracotta
  static const Color terracotta = Color(0xFFC45D3A);
  static const Color warmCoral = Color(0xFFE07A55);

  // Secondary — Sage
  static const Color sage = Color(0xFF5A7D6E);
  static const Color mutedSage = Color(0xFF7DAF9A);

  // A1 accent — Indigo
  static const Color indigo = Color(0xFF4A6FA5);
  static const Color periwinkle = Color(0xFF8BAEE0);

  // A2 accent — Aubergine
  static const Color aubergine = Color(0xFF7B4B8C);
  static const Color lavender = Color(0xFFB892C9);

  // Type colours
  static const Color verbCoral = Color(0xFFD96C5E);
  static const Color verbSalmon = Color(0xFFE88A7D);
  static const Color nounOchre = Color(0xFFC9A227);
  static const Color nounGold = Color(0xFFE0C060);

  // Text
  static const Color ink = Color(0xFF1E1E1E);
  static const Color offWhite = Color(0xFFE8E6E1);
  static const Color warmGrey = Color(0xFF6B6560);
  static const Color mutedGrey = Color(0xFF9E9A94);

  // Dark surface border
  static const Color darkBorder = Color(0xFF2A2D35);

  // ── Legacy aliases for backward compatibility ────────────────
  static Color get coral => verbCoral;
  static Color get gold => nounOchre;
  static Color get purple => aubergine;
  static Color get blue => indigo;
  static Color get accentLight => terracotta;
  static Color get accentDark => warmCoral;
  static Color get surfaceDark => charcoal;
  static Color get surfaceLight => creamPaper;
  static Color get bgLight => parchment;
  static Color get bgDark => deepInk;
  static Color get cardLight => creamPaper;
  static Color get cardDark => charcoal;
  static Color get secondary => sage;

  // Radius tokens
  static const double radiusXs = 8;
  static const double radiusSm = 12;
  static const double radius = 16;
  static const double radiusPill = 999;

  // ── Typography helpers ────────────────────────────────────────

  static TextStyle _serif(double size,
          {FontWeight w = FontWeight.w600, Color? c, double? h}) =>
      GoogleFonts.playfairDisplay(
          fontSize: size, fontWeight: w, color: c, height: h);

  static TextStyle _sans(double size,
          {FontWeight w = FontWeight.w400, Color? c, double? h, double? ls}) =>
      GoogleFonts.inter(
          fontSize: size,
          fontWeight: w,
          color: c,
          height: h,
          letterSpacing: ls);

  // ── Build theme data ──────────────────────────────────────────

  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        bg: parchment,
        surface: creamPaper,
        primary: terracotta,
        secondary: sage,
        a1: indigo,
        a2: aubergine,
        verb: verbCoral,
        noun: nounOchre,
        textPrimary: ink,
        textSecondary: warmGrey,
        borderColor: Colors.black.withValues(alpha: 0.06),
        cardBorder: Colors.black.withValues(alpha: 0.04),
        dividerColor: Colors.black.withValues(alpha: 0.05),
        inputFill: Colors.white,
      );

  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        bg: deepInk,
        surface: charcoal,
        primary: warmCoral,
        secondary: mutedSage,
        a1: periwinkle,
        a2: lavender,
        verb: verbSalmon,
        noun: nounGold,
        textPrimary: offWhite,
        textSecondary: mutedGrey,
        borderColor: Colors.white.withValues(alpha: 0.05),
        cardBorder: darkBorder,
        dividerColor: Colors.white.withValues(alpha: 0.05),
        inputFill: const Color(0xFF14161C),
      );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color primary,
    required Color secondary,
    required Color a1,
    required Color a2,
    required Color verb,
    required Color noun,
    required Color textPrimary,
    required Color textSecondary,
    required Color borderColor,
    required Color cardBorder,
    required Color dividerColor,
    required Color inputFill,
  }) {
    final isDark = brightness == Brightness.dark;
    final cs = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: isDark ? deepInk : Colors.white,
      secondary: secondary,
      onSecondary: Colors.white,
      surface: surface,
      onSurface: textPrimary,
      error: verb,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bg,
      colorScheme: cs,
      fontFamily: GoogleFonts.inter().fontFamily,

      // ── App Bar ───────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0.5,
        titleTextStyle: _sans(18, w: FontWeight.w700, c: textPrimary),
      ),

      // ── Cards ─────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: isDark ? 0 : 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: isDark
              ? BorderSide(color: cardBorder, width: 1)
              : BorderSide.none,
        ),
      ),

      // ── Bottom Sheet ──────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: true,
      ),

      // ── Input / Search ────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusPill),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusPill),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusPill),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: _sans(14, c: textSecondary),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        isDense: true,
      ),

      // ── Chips ─────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: isDark ? const Color(0xFF14161C) : Colors.white,
        selectedColor: primary.withValues(alpha: 0.12),
        side: BorderSide(color: borderColor),
        labelStyle: _sans(12, w: FontWeight.w600, c: textPrimary),
        secondaryLabelStyle: _sans(12, w: FontWeight.w700, c: primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusPill),
        ),
      ),

      // ── Buttons ───────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPill),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: isDark ? deepInk : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPill),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPill),
          ),
        ),
      ),

      // ── Dividers ──────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: dividerColor,
        thickness: 0.5,
        space: 0.5,
      ),

      // ─── Icons ────────────────────────────────────────────────
      iconTheme: IconThemeData(color: textSecondary, size: 22),

      // ── ListTile ──────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        textColor: textPrimary,
        iconColor: textSecondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      // ── Text Selection ────────────────────────────────────────
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primary,
        selectionColor: primary.withValues(alpha: 0.24),
        selectionHandleColor: primary,
      ),

      // ── SnackBar ──────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? charcoal : surface,
        contentTextStyle: _sans(14, c: textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),

      // ── Text Theme ────────────────────────────────────────────
      textTheme: TextTheme(
        // Serif display styles
        displayLarge: _serif(32, w: FontWeight.w800, c: textPrimary),
        displayMedium: _serif(28, w: FontWeight.w700, c: textPrimary),
        displaySmall: _serif(24, w: FontWeight.w700, c: textPrimary),
        headlineLarge: _serif(22, w: FontWeight.w700, c: textPrimary),
        headlineMedium: _serif(20, w: FontWeight.w600, c: textPrimary),
        headlineSmall: _serif(18, w: FontWeight.w600, c: textPrimary),

        // Sans body styles
        titleLarge: _sans(18, w: FontWeight.w700, c: textPrimary),
        titleMedium: _sans(16, w: FontWeight.w600, c: textPrimary),
        titleSmall: _sans(14, w: FontWeight.w600, c: textSecondary),
        bodyLarge: _sans(16, w: FontWeight.w400, c: textPrimary, h: 1.5),
        bodyMedium: _sans(14, w: FontWeight.w400, c: textPrimary, h: 1.45),
        bodySmall: _sans(13, w: FontWeight.w400, c: textSecondary, h: 1.4),
        labelLarge: _sans(14, w: FontWeight.w700, c: primary),
        labelMedium: _sans(12, w: FontWeight.w600, c: textSecondary),
        labelSmall: _sans(11, w: FontWeight.w500, c: textSecondary, ls: 0.5),
      ),
    );
  }

  // ── Helper accessors for accent colours ───────────────────────

  static Color a1Color(bool isDark) => isDark ? periwinkle : indigo;
  static Color a2Color(bool isDark) => isDark ? lavender : aubergine;
  static Color verbColor(bool isDark) => isDark ? verbSalmon : verbCoral;
  static Color nounColor(bool isDark) => isDark ? nounGold : nounOchre;
}
