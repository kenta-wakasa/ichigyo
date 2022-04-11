import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static const primaryColor = Color.fromRGBO(52, 52, 23, 1);
  static const secondaryColor = Color.fromRGBO(52, 52, 23, 1);
  static const fontColor = Color.fromRGBO(52, 52, 23, 1);

  static final baseTheme = ThemeData(textTheme: GoogleFonts.sawarabiGothicTextTheme());

  static ThemeData get theme => ThemeData(
        primaryColor: primaryColor,
        colorScheme: baseTheme.colorScheme.copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        textTheme: baseTheme.textTheme.apply(
          bodyColor: AppTheme.fontColor,
          displayColor: AppTheme.fontColor,
          decorationColor: AppTheme.fontColor,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 249, 248, 245),
      );
}
