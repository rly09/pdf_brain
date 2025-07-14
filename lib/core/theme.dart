import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color lightPrimary = Color(0xFF4B63FF);
final Color lightSecondary = Color(0xFF91A6FF);
final Color lightBackground = Color(0xFFF7F9FC);

final Color darkPrimary = Color(0xFF90A4FF);
final Color darkSecondary = Color(0xFFB0C4FF);
final Color darkBackground = Color(0xFF121212);

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: lightPrimary,
    secondary: lightSecondary,
    background: lightBackground,
  ),
  scaffoldBackgroundColor: lightBackground,
  textTheme: GoogleFonts.urbanistTextTheme().apply(
    bodyColor: Colors.black87,
    displayColor: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.5,
    iconTheme: IconThemeData(color: lightPrimary),
    titleTextStyle: GoogleFonts.urbanist(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightPrimary,
      foregroundColor: Colors.white,
      textStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: darkPrimary,
    secondary: darkSecondary,
    background: darkBackground,
  ),
  scaffoldBackgroundColor: darkBackground,
  textTheme: GoogleFonts.urbanistTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0.5,
    iconTheme: IconThemeData(color: darkPrimary),
    titleTextStyle: GoogleFonts.urbanist(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  cardTheme: CardThemeData(
    color: Color(0xFF1E1E1E),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkPrimary,
      foregroundColor: Colors.white,
      textStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);
