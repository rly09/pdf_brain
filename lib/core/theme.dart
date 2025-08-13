import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors - Light Mode
final Color lightPrimary = Color(0xFF3E63FF);
final Color lightSecondary = Color(0xFF8FA6FF);
final Color lightAccent = Color(0xFF4DD0E1);
final Color lightBackground = Color(0xFFF4F6FB);
final Color lightCard = Colors.white.withOpacity(0.8);

// Colors - Dark Mode
final Color darkPrimary = Color(0xFF9BAFFF);
final Color darkSecondary = Color(0xFFB4C6FF);
final Color darkAccent = Color(0xFF26C6DA);
final Color darkBackground = Color(0xFF0E0F14);
final Color darkCard = Colors.white.withOpacity(0.05);

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: lightPrimary,
    secondary: lightSecondary,
    tertiary: lightAccent,
    background: lightBackground,
  ),
  scaffoldBackgroundColor: lightBackground,
  textTheme: GoogleFonts.urbanistTextTheme().apply(
    bodyColor: Colors.black87,
    displayColor: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white.withOpacity(0.9),
    elevation: 0,
    shadowColor: Colors.black12,
    iconTheme: IconThemeData(color: lightPrimary),
    titleTextStyle: GoogleFonts.urbanist(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    centerTitle: true,
  ),
  cardTheme: CardTheme(
    color: lightCard,
    elevation: 5,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightPrimary,
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: lightPrimary.withOpacity(0.3),
      textStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: darkPrimary,
    secondary: darkSecondary,
    tertiary: darkAccent,
    background: darkBackground,
  ),
  scaffoldBackgroundColor: darkBackground,
  textTheme: GoogleFonts.urbanistTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black.withOpacity(0.8),
    elevation: 0,
    shadowColor: Colors.white10,
    iconTheme: IconThemeData(color: darkPrimary),
    titleTextStyle: GoogleFonts.urbanist(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    centerTitle: true,
  ),
  cardTheme: CardTheme(
    color: darkCard,
    elevation: 5,
    shadowColor: Colors.white10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkPrimary,
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: darkPrimary.withOpacity(0.3),
      textStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ),
  ),
);
