import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// todo: refactoring
ThemeData get droidKaigiLightTheme {
  return ThemeData(
    primaryColor: DroidKaigiColors.indigo900,
    primaryColorBrightness: Brightness.light,
    accentColor: DroidKaigiColors.lightBlue300,
    accentColorBrightness: Brightness.light,
    cardColor: DroidKaigiColors.white,
    backgroundColor: DroidKaigiColors.white,
    scaffoldBackgroundColor: DroidKaigiColors.white,
    colorScheme: const ColorScheme(
      primary: DroidKaigiColors.indigo900,
      primaryVariant: DroidKaigiColors.indigo900,
      secondary: DroidKaigiColors.lightBlue300,
      secondaryVariant: DroidKaigiColors.lightBlue300,
      background: DroidKaigiColors.white,
      surface: DroidKaigiColors.white,
      error: DroidKaigiColors.error,
      onPrimary: DroidKaigiColors.white,
      onSecondary: DroidKaigiColors.black,
      onBackground: DroidKaigiColors.blackAlpha87,
      onSurface: DroidKaigiColors.black,
      onError: DroidKaigiColors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      color: DroidKaigiColors.indigo900,
      iconTheme: IconThemeData(
        color: DroidKaigiColors.white,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: DroidKaigiColors.white,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: DroidKaigiColors.white,
          ),
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: DroidKaigiColors.indigo900,
    ),
    textTheme: droidKaigiTextTheme(),
  );
}

ThemeData get droidKaigiDarkTheme {
  return ThemeData(
    primaryColor: DroidKaigiColors.black212121,
    primaryColorBrightness: Brightness.dark,
    accentColor: DroidKaigiColors.lightBlue300,
    accentColorBrightness: Brightness.light,
    cardColor: DroidKaigiColors.black303030,
    backgroundColor: DroidKaigiColors.black212121,
    scaffoldBackgroundColor: DroidKaigiColors.black212121,
    canvasColor: DroidKaigiColors.black303030,
    colorScheme: const ColorScheme(
      primary: DroidKaigiColors.black212121,
      primaryVariant: DroidKaigiColors.black212121,
      secondary: DroidKaigiColors.lightBlue300,
      secondaryVariant: DroidKaigiColors.lightBlue300,
      background: DroidKaigiColors.black212121,
      surface: DroidKaigiColors.white,
      error: DroidKaigiColors.error,
      onPrimary: DroidKaigiColors.white,
      onSecondary: DroidKaigiColors.black,
      onBackground: DroidKaigiColors.white,
      onSurface: DroidKaigiColors.black,
      onError: DroidKaigiColors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      color: DroidKaigiColors.black212121,
      elevation: 0,
      iconTheme: IconThemeData(
        color: DroidKaigiColors.white,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: DroidKaigiColors.indigo200,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: DroidKaigiColors.indigo200,
          ),
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: DroidKaigiColors.black424242,
    ),
    textTheme: droidKaigiTextTheme(isDark: true),
  );
}

// ref: https://material.io/develop/android/theming/typography/
TextTheme droidKaigiTextTheme({bool isDark = false}) {
  return GoogleFonts.notoSansJPTextTheme(
    TextTheme(
      title: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      subtitle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.indigo900,
      ),
      headline: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      subhead: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      body1: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      body2: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      display1: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 34,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      display2: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 48,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      display3: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 60,
        color: DroidKaigiColors.blackAlpha87,
      ),
      display4: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 96,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      caption: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      overline: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 10,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: isDark ? DroidKaigiColors.white : DroidKaigiColors.blackAlpha87,
      ),
    ),
  );
}

// ref: https://github.com/DroidKaigi/visual-identity/blob/master/Guideline.pdf
class DroidKaigiColors {
  DroidKaigiColors._();

  static const indigo50 = Color(0xFFe4e8ed);
  static const indigo100 = Color(0xFFbbc5d5);
  static const indigo200 = Color(0xFF8f9fb8);
  static const indigo300 = Color(0xFF667b9c);
  static const indigo400 = Color(0xFF456089);
  static const indigo500 = Color(0xFF214779);
  static const indigo600 = Color(0xFF1a4071);
  static const indigo700 = Color(0xFF103766);
  static const indigo800 = Color(0xFF092e59);
  static const indigo900 = Color(0xFF041e42);

  static const cyan50 = Color(0xFFe2f8ed);
  static const cyan100 = Color(0xFFb9edd2);
  static const cyan200 = Color(0xFF89e1b6);
  static const cyan300 = Color(0xFF48d598);
  static const cyan400 = Color(0xFF00cb81);
  static const cyan500 = Color(0xFF00c06b);
  static const cyan600 = Color(0xFF00b060);
  static const cyan700 = Color(0xFF009d53);
  static const cyan800 = Color(0xFF008b47);
  static const cyan900 = Color(0xFF006b31);

  static const lightBlue300 = Color(0xFF00b5e2);

  static const white = Color(0xFFFFFFFF);
  static const gray = Color(0xFF212121);
  static const black = Color(0xFF000000);

  static const error = Color(0xFFe06287);
  static const warning = Color(0xFFe8e012);

  static const blackAlpha87 = Color(0xDE000000);
  static const blackAlpha38 = Color(0x61000000);
  static const blackAlpha12 = Color(0x1F000000);

  static const black121212 = Color(0xFF121212);
  static const black212121 = Color(0xff212121);
  static const black303030 = Color(0xff303030);
  static const black424242 = Color(0xff424242);
}
