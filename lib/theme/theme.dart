import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BakeryTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _createMaterialColor(primaryColor),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surfaceBright: backgroundColorLight,
      surface: surfaceColorLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurfaceVariant: textColorLight,
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
        side: const BorderSide(color: primaryColor, width: 1.5),
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
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 2),
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
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surfaceBright: backgroundColorDark,
      surface: surfaceColorDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurfaceVariant: textColorDark,
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
        borderSide: const BorderSide(color: primaryColor, width: 2),
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
  static const Color backgroundColorLight = Color(0xFFFDF6E9); // Cream/off-white
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

// Custom Text Styles for easy access
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

// Widget Extension for easy styling
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
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