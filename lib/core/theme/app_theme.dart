import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF007AFF); 
  static const Color accentColor = Color(0xFF5856D6); 

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      surface: const Color(0xFFF2F2F7), // Apple System Gray 6
      onSurface: Colors.black,
      secondary: accentColor,
      surfaceVariant: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.outfitTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.5,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      color: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      surface: const Color(0xFF1C1C1E), // Apple Dark Gray
      onSurface: Colors.white,
      secondary: accentColor,
      surfaceVariant: const Color(0xFF2C2C2E),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212), // Deep charcoal instead of black
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black.withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.5,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      color: const Color(0xFF1C1C1E),
    ),
  );
}
