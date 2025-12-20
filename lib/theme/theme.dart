// lib/core/theme/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BakeryTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _createMaterialColor(primaryColor),
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColorLight,
      surface: surfaceColorLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: textColorLight,
      onSurface: textColorLight,
      error: errorColor,
    ),
    scaffoldBackgroundColor: backgroundColorLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: textColorLight,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        color: textColorLight,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: textColorLight,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColorLight,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: textColorLight,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textColorLight,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColorLight,
      ),
      titleMedium: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textColorLight,
      ),
      titleSmall: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColorLight,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColorLight,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColorLight,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColorLight,
      ),
      labelLarge: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: GoogleFonts.montserrat(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintStyle: GoogleFonts.montserrat(
        color: Colors.grey[500],
        fontSize: 14,
      ),
      labelStyle: GoogleFonts.montserrat(
        color: Colors.grey[700],
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      errorStyle: GoogleFonts.montserrat(
        color: errorColor,
        fontSize: 12,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceColorLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: surfaceColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColorLight,
      ),
      contentTextStyle: GoogleFonts.montserrat(
        fontSize: 14,
        color: textColorLight,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.montserrat(
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey[100]!,
      selectedColor: primaryColor.withOpacity(0.2),
      checkmarkColor: primaryColor,
      labelStyle: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[300],
      thickness: 1,
      space: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryColor,
      contentTextStyle: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      behavior: SnackBarBehavior.floating,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: _createMaterialColor(primaryColor),
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColorDark,
      surface: surfaceColorDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: textColorDark,
      onSurface: textColorDark,
      error: errorColor,
    ),
    scaffoldBackgroundColor: backgroundColorDark,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColorDark,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: textColorDark,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        color: textColorDark,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: textColorDark,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textColorDark,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: textColorDark,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: textColorDark,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColorDark,
      ),
      titleMedium: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: textColorDark,
      ),
      titleSmall: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColorDark,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColorDark,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColorDark,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColorDark,
      ),
      labelLarge: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      labelSmall: GoogleFonts.montserrat(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceColorDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColorDark.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[700]!, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    ),
  );

  // Color Palette - Warm Bakery Theme
  static const Color primaryColor = Color(0xFFD4A574); // Warm beige/brown
  static const Color secondaryColor = Color(0xFF8B4513); // Chocolate brown
  static const Color accentColor = Color(0xFFFFD166); // Golden yellow
  static const Color errorColor = Color(0xFFE63946); // Soft red
  static const Color successColor = Color(0xFF2A9D8F); // Teal green

  // Light Theme Colors
  static const Color backgroundColorLight =
      Color(0xFFFDF6E9); // Cream/off-white
  static const Color surfaceColorLight = Color(0xFFFFFFFF); // Pure white
  static const Color textColorLight = Color(0xFF3C2A1E); // Dark brown

  // Dark Theme Colors
  static const Color backgroundColorDark = Color(0xFF1A1A1A);
  static const Color surfaceColorDark = Color(0xFF2D2D2D);
  static const Color textColorDark = Color(0xFFF0E6D3); // Cream text

  // Font Families
  static String primaryFont = GoogleFonts.playfairDisplay().fontFamily!;
  static String secondaryFont = GoogleFonts.montserrat().fontFamily!;

  // Helper function to create MaterialColor from Color
  static MaterialColor _createMaterialColor(Color color) {
    List<double> strengths = [.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}

// ==============================================
// ENHANCED WIDGET STYLES & UTILITIES
// ==============================================

/// Custom widget decorations for consistent styling
class BakeryDecorations {
  // Card decorations
  static BoxDecoration get cardLight => BoxDecoration(
        color: BakeryTheme.surfaceColorLight,
        borderRadius: BakeryBorderRadius.lg,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      );

  static BoxDecoration get cardDark => BoxDecoration(
        color: BakeryTheme.surfaceColorDark,
        borderRadius: BakeryBorderRadius.lg,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      );

  // Product card decoration
  static BoxDecoration get productCardLight => BoxDecoration(
        color: BakeryTheme.surfaceColorLight,
        borderRadius: BakeryBorderRadius.md,
        border: Border.all(
          color: const Color(0xFFF0F0F0),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      );

  static BoxDecoration get productCardDark => BoxDecoration(
        color: BakeryTheme.surfaceColorDark,
        borderRadius: BakeryBorderRadius.md,
        border: Border.all(
          color: const Color(0xFF404040),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      );

  // Order status badge decorations
  static BoxDecoration getStatusBadge(String status, bool isDark) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = const Color(0xFFFFF3CD);
        textColor = const Color(0xFF856404);
        borderColor = const Color(0xFFFFEEBA);
        break;
      case 'confirmed':
        backgroundColor = const Color(0xFFD1ECF1);
        textColor = const Color(0xFF0C5460);
        borderColor = const Color(0xFFBEE5EB);
        break;
      case 'preparing':
        backgroundColor = const Color(0xFFFFF0CD);
        textColor = const Color(0xFF8A6D3B);
        borderColor = const Color(0xFFF8E0B0);
        break;
      case 'ready':
        backgroundColor = const Color(0xFFD4EDDA);
        textColor = const Color(0xFF155724);
        borderColor = const Color(0xFFC3E6CB);
        break;
      case 'completed':
        backgroundColor = const Color(0xFFD4EDDA);
        textColor = const Color(0xFF155724);
        borderColor = const Color(0xFFC3E6CB);
        break;
      case 'cancelled':
        backgroundColor = const Color(0xFFF8D7DA);
        textColor = const Color(0xFF721C24);
        borderColor = const Color(0xFFF5C6CB);
        break;
      default:
        backgroundColor = const Color(0xFFF8F9FA);
        textColor = const Color(0xFF6C757D);
        borderColor = const Color(0xFFE9ECEF);
    }

    if (isDark) {
      // Dark mode adjustments
      backgroundColor = backgroundColor.withOpacity(0.2);
      borderColor = borderColor.withOpacity(0.3);
    }

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BakeryBorderRadius.round,
      border: Border.all(
        color: borderColor,
        width: 1,
      ),
    );
  }

  // Price tag decoration
  static BoxDecoration get priceTagLight => BoxDecoration(
        color: BakeryTheme.primaryColor,
        borderRadius: BakeryBorderRadius.sm,
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      );

  static BoxDecoration get priceTagDark => BoxDecoration(
        color: BakeryTheme.primaryColor,
        borderRadius: BakeryBorderRadius.sm,
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 6,
            offset: Offset(0, 3),
            spreadRadius: 0,
          ),
        ],
      );

  // Featured product decoration
  static BoxDecoration get featuredProductLight => BoxDecoration(
        color: BakeryTheme.surfaceColorLight,
        borderRadius: BakeryBorderRadius.lg,
        border: Border.all(
          color: BakeryTheme.accentColor,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1AFFD166),
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      );

  static BoxDecoration get featuredProductDark => BoxDecoration(
        color: BakeryTheme.surfaceColorDark,
        borderRadius: BakeryBorderRadius.lg,
        border: Border.all(
          color: BakeryTheme.accentColor,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33FFD166),
            blurRadius: 16,
            offset: Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      );

  // Input field decoration
  static BoxDecoration get inputFieldLight => BoxDecoration(
        color: Colors.white,
        borderRadius: BakeryBorderRadius.md,
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
      );

  static BoxDecoration get inputFieldDark => BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BakeryBorderRadius.md,
        border: Border.all(
          color: const Color(0xFF404040),
          width: 1,
        ),
      );
}

/// Status color utilities
class BakeryStatusColors {
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFFC107); // Amber
      case 'confirmed':
        return const Color(0xFF17A2B8); // Teal
      case 'preparing':
        return const Color(0xFFFD7E14); // Orange
      case 'ready':
        return const Color(0xFF28A745); // Green
      case 'completed':
        return const Color(0xFF28A745); // Green
      case 'cancelled':
        return const Color(0xFFDC3545); // Red
      default:
        return const Color(0xFF6C757D); // Gray
    }
  }

  static Color getStatusBackground(String status, bool isDark) {
    final color = getStatusColor(status);
    return isDark ? color.withOpacity(0.2) : color.withOpacity(0.1);
  }

  static Color getStatusText(String status, bool isDark) {
    final color = getStatusColor(status);
    return isDark ? color.lighten(0.2) : color.darken(0.2);
  }
}

/// Color extension for darken/lighten operations
extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

/// Custom Text Styles for easy access
class BakeryTextStyles {
  // Display Styles (Playfair Display)
  static TextStyle displayLarge(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge!;
  }

  static TextStyle displayMedium(BuildContext context) {
    return Theme.of(context).textTheme.displayMedium!;
  }

  static TextStyle displaySmall(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall!;
  }

  // Headline Styles (Playfair Display)
  static TextStyle headlineLarge(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!;
  }

  static TextStyle headlineMedium(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!;
  }

  static TextStyle headlineSmall(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!;
  }

  // Title Styles (Montserrat)
  static TextStyle titleLarge(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!;
  }

  static TextStyle titleMedium(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!;
  }

  static TextStyle titleSmall(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!;
  }

  // Body Styles (Montserrat)
  static TextStyle bodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }

  // Label Styles (Montserrat)
  static TextStyle labelLarge(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!;
  }

  static TextStyle labelMedium(BuildContext context) {
    return Theme.of(context).textTheme.labelMedium!;
  }

  static TextStyle labelSmall(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!;
  }

  // Custom App Text Styles
  static TextStyle appBarTitle(BuildContext context) {
    return GoogleFonts.playfairDisplay(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).appBarTheme.foregroundColor,
    );
  }

  static TextStyle productName(BuildContext context) {
    return GoogleFonts.playfairDisplay(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.titleLarge?.color,
    );
  }

  static TextStyle productPrice(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: BakeryTheme.primaryColor,
    );
  }

  static TextStyle productDescription(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
    );
  }

  static TextStyle sectionTitle(BuildContext context) {
    return GoogleFonts.playfairDisplay(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.headlineSmall?.color,
    );
  }

  static TextStyle buttonPrimary(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  static TextStyle buttonSecondary(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: BakeryTheme.primaryColor,
    );
  }

  static TextStyle chipLabel(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
  }
}

/// Enhanced text utility classes
class BakeryText {
  // Product-related text styles
  static TextStyle productName(BuildContext context,
      {bool isFeatured = false}) {
    final theme = Theme.of(context);
    return GoogleFonts.playfairDisplay(
      fontSize: isFeatured ? 20 : 18,
      fontWeight: isFeatured ? FontWeight.w700 : FontWeight.w600,
      color: theme.textTheme.titleLarge?.color,
    );
  }

  static TextStyle productPrice(BuildContext context, {bool isOnSale = false}) {
    return GoogleFonts.montserrat(
      fontSize: isOnSale ? 18 : 20,
      fontWeight: FontWeight.w700,
      color: isOnSale ? BakeryTheme.errorColor : BakeryTheme.primaryColor,
      decoration: isOnSale ? TextDecoration.lineThrough : TextDecoration.none,
    );
  }

  static TextStyle productSalePrice(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: BakeryTheme.successColor,
    );
  }

  static TextStyle productCategory(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: BakeryTheme.textColorLight.withOpacity(0.6),
      letterSpacing: 0.5,
    );
  }

  // Order-related text styles
  static TextStyle orderNumber(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.titleMedium?.color,
      letterSpacing: 0.5,
    );
  }

  static TextStyle orderDate(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).textTheme.bodySmall?.color,
    );
  }

  static TextStyle orderTotal(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: BakeryTheme.primaryColor,
    );
  }

  // Status text with styling
  static Widget statusText(
    BuildContext context,
    String status, {
    bool showBadge = true,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final text = Text(
      status.toUpperCase(),
      style: GoogleFonts.montserrat(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: BakeryStatusColors.getStatusText(status, isDarkMode),
      ),
    );

    if (!showBadge) {
      return text;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BakerySpacing.sm,
        vertical: BakerySpacing.xs / 2,
      ),
      decoration: BakeryDecorations.getStatusBadge(status, isDarkMode),
      child: text,
    );
  }

  // Section headers
  static TextStyle sectionHeader(BuildContext context) {
    return GoogleFonts.playfairDisplay(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.headlineSmall?.color,
    );
  }

  static TextStyle sectionSubheader(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
    );
  }

  // Empty state text
  static TextStyle emptyStateTitle(BuildContext context) {
    return GoogleFonts.playfairDisplay(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.titleLarge?.color?.withOpacity(0.8),
    );
  }

  static TextStyle emptyStateSubtitle(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
    );
  }
}

/// Button style utilities
class BakeryButtons {
  static ButtonStyle primaryButton(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: BakeryTheme.primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: BakerySpacing.lg,
        vertical: BakerySpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BakeryBorderRadius.md,
      ),
      textStyle: BakeryTextStyles.buttonPrimary(context),
      elevation: 2,
      shadowColor: BakeryTheme.primaryColor.withOpacity(0.3),
    );
  }

  static ButtonStyle secondaryButton(BuildContext context) {
    return OutlinedButton.styleFrom(
      foregroundColor: BakeryTheme.primaryColor,
      side: BorderSide(
        color: BakeryTheme.primaryColor,
        width: 1.5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: BakerySpacing.lg,
        vertical: BakerySpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BakeryBorderRadius.md,
      ),
      textStyle: BakeryTextStyles.buttonSecondary(context),
    );
  }

  static ButtonStyle successButton(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: BakeryTheme.successColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: BakerySpacing.lg,
        vertical: BakerySpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BakeryBorderRadius.md,
      ),
      textStyle: BakeryTextStyles.buttonPrimary(context).copyWith(
        color: Colors.white,
      ),
      elevation: 2,
    );
  }

  static ButtonStyle smallButton(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: BakeryTheme.primaryColor,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: BakerySpacing.md,
        vertical: BakerySpacing.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BakeryBorderRadius.sm,
      ),
      textStyle: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      elevation: 1,
    );
  }

  static ButtonStyle iconButton(BuildContext context) {
    return IconButton.styleFrom(
      backgroundColor: BakeryTheme.primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BakeryBorderRadius.md,
      ),
      padding: const EdgeInsets.all(BakerySpacing.md),
    );
  }
}

/// Widget extensions for easy styling
extension WidgetStyling on Widget {
  Widget withCardStyle(BuildContext context, {bool isDark = false}) {
    return Container(
      decoration:
          isDark ? BakeryDecorations.cardDark : BakeryDecorations.cardLight,
      child: this,
    );
  }

  Widget withPaddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget withPaddingHorizontal(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: this,
    );
  }

  Widget withPaddingVertical(double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: this,
    );
  }

  Widget withMarginAll(double margin) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: this,
    );
  }

  Widget withMarginHorizontal(double margin) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      child: this,
    );
  }

  Widget withMarginVertical(double margin) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      child: this,
    );
  }

  Widget withBorderRadius(BorderRadius radius) {
    return ClipRRect(
      borderRadius: radius,
      child: this,
    );
  }
}

/// Theme data extension for additional utilities
extension ThemeDataExtension on ThemeData {
  bool get isDark => brightness == Brightness.dark;

  Color get cardColor =>
      isDark ? BakeryTheme.surfaceColorDark : BakeryTheme.surfaceColorLight;

  Color get textSecondaryColor => isDark
      ? BakeryTheme.textColorDark.withOpacity(0.7)
      : BakeryTheme.textColorLight.withOpacity(0.7);

  Color get dividerColor =>
      isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1);
}

/// Quick access extension for BuildContext
extension BakeryThemeExtension on BuildContext {
  // Theme data
  ThemeData get theme => Theme.of(this);
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // Colors
  Color get primaryColor => BakeryTheme.primaryColor;
  Color get secondaryColor => BakeryTheme.secondaryColor;
  Color get accentColor => BakeryTheme.accentColor;
  Color get errorColor => BakeryTheme.errorColor;
  Color get successColor => BakeryTheme.successColor;

  // Spacing
  EdgeInsets get defaultPadding => const EdgeInsets.all(BakerySpacing.md);
  EdgeInsets get cardPadding => const EdgeInsets.all(BakerySpacing.lg);
  EdgeInsets get screenPadding => const EdgeInsets.all(BakerySpacing.xl);

  // Text styles via BakeryText
  TextStyle get sectionHeaderStyle => BakeryText.sectionHeader(this);
  TextStyle get productNameStyle => BakeryText.productName(this);
  TextStyle get productPriceStyle => BakeryText.productPrice(this);
  TextStyle get orderTotalStyle => BakeryText.orderTotal(this);

  // Decorations
  BoxDecoration get cardDecoration =>
      isDarkMode ? BakeryDecorations.cardDark : BakeryDecorations.cardLight;

  BoxDecoration get productCardDecoration => isDarkMode
      ? BakeryDecorations.productCardDark
      : BakeryDecorations.productCardLight;

  // Buttons
  ButtonStyle get primaryButtonStyle => BakeryButtons.primaryButton(this);
  ButtonStyle get secondaryButtonStyle => BakeryButtons.secondaryButton(this);
  ButtonStyle get successButtonStyle => BakeryButtons.successButton(this);

  // Status widget
  Widget statusBadge(String status) => BakeryText.statusText(this, status);
}

// Custom Padding Constants
class BakerySpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

// Border Radius Constants
class BakeryBorderRadius {
  static const BorderRadius xs = BorderRadius.all(Radius.circular(4));
  static const BorderRadius sm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius md = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(24));
  static const BorderRadius round = BorderRadius.all(Radius.circular(999));
}

// Widget Extension for easy styling
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
