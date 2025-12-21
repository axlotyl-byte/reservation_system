import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BakeryTheme {
  // =========================
  // LIGHT THEME
  // =========================
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _createMaterialColor(primaryColor),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColorLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textColorLight,
      error: errorColor,
    ),
    scaffoldBackgroundColor: backgroundColorLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: _textTheme(textColorLight),
    elevatedButtonTheme: _elevatedButtonTheme(),
    outlinedButtonTheme: _outlinedButtonTheme(),
    textButtonTheme: _textButtonTheme(),
    inputDecorationTheme: _inputDecorationTheme(isDark: false),
    cardTheme: _cardTheme(surfaceColorLight),
    snackBarTheme: _snackBarTheme(),
    floatingActionButtonTheme: _fabTheme(),
  );

  // =========================
  // DARK THEME
  // =========================
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: _createMaterialColor(primaryColor),
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColorDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textColorDark,
      error: errorColor,
    ),
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColorDark,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: _textTheme(textColorDark),
    elevatedButtonTheme: _elevatedButtonTheme(),
    inputDecorationTheme: _inputDecorationTheme(isDark: true),
    cardTheme: _cardTheme(surfaceColorDark),
    snackBarTheme: _snackBarTheme(),
    floatingActionButtonTheme: _fabTheme(),
  );

  // =========================
  // COLORS (Bakery Palette)
  // =========================
  static const Color primaryColor = Color(0xFFD4A574);
  static const Color secondaryColor = Color(0xFF8B4513);
  static const Color accentColor = Color(0xFFFFD166);
  static const Color errorColor = Color(0xFFE63946);
  static const Color successColor = Color(0xFF2A9D8F);

  // Light
  static const Color backgroundColorLight = Color(0xFFFDF6E9);
  static const Color surfaceColorLight = Color(0xFFFFFFFF);
  static const Color textColorLight = Color(0xFF3C2A1E);

  // Dark
  static const Color backgroundColorDark = Color(0xFF1A1A1A);
  static const Color surfaceColorDark = Color(0xFF2D2D2D);
  static const Color textColorDark = Color(0xFFF0E6D3);

  // =========================
  // THEME HELPERS
  // =========================
  static TextTheme _textTheme(Color textColor) {
    return TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 16,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        color: textColor,
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme({required bool isDark}) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isDark ? surfaceColorDark : Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static CardTheme _cardTheme(Color color) {
    return CardTheme(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  static SnackBarThemeData _snackBarTheme() {
    return SnackBarThemeData(
      backgroundColor: primaryColor,
      contentTextStyle: GoogleFonts.montserrat(
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
    );
  }

  static FloatingActionButtonThemeData _fabTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    );
  }

  // MaterialColor helper
  static MaterialColor _createMaterialColor(Color color) {
    final Map<int, Color> swatch = {};
    for (int i = 1; i <= 9; i++) {
      final double strength = i * 0.1;
      swatch[(strength * 1000).round()] =
          Color.lerp(Colors.white, color, strength)!;
    }
    return MaterialColor(color.value, swatch);
  }
}

// =========================
// TEXT STYLE SHORTCUTS
// =========================
class BakeryTextStyles {
  static TextStyle title(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle body(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle price(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: BakeryTheme.primaryColor,
      );
}

// =========================
// SPACING CONSTANTS
// =========================
class BakerySpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

// =========================
// BORDER RADIUS
// =========================
class BakeryBorderRadius {
  static const BorderRadius sm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius md = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius round = BorderRadius.all(Radius.circular(999));
}
