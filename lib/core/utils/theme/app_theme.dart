import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color backgroundColor = Color(0xFF000000);
  static const Color cardBackgroundColor = Color(0xFF1E1E1E);
  static const Color accentColor = Color(0xFF00E5FF);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardBackgroundColor,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF0D0D0D),
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
    ),
  );
}
