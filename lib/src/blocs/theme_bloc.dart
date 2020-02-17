import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unofficial_conference_app_2020/src/resources/preferences/preferences.dart';
import 'package:unofficial_conference_app_2020/src/utility/droid_kaigi_theme.dart';

class ThemeBloc {
  ThemeBloc() {
    _initTheme();
  }

  void dispose() {
    _themeSubject.close();
  }

  ThemeData get lightTheme => droidKaigiLightTheme;
  ThemeData get darkTheme => droidKaigiDarkTheme;

  ThemeMode _selectTheme;
  ThemeMode get selectTheme => _selectTheme;

  bool get isDark => selectTheme == ThemeMode.dark;

  final _themeSubject = PublishSubject<ThemeMode>();
  Observable<ThemeMode> get themeMode => _themeSubject.stream;

  void _initTheme() async {
    _selectTheme =
        (await Preferences.isDarkMode ? ThemeMode.dark : ThemeMode.light);
    _themeSubject.sink.add(_selectTheme);
  }

  void changeTheme(bool selectDark) {
    _selectTheme = selectDark ? ThemeMode.dark : ThemeMode.light;
    Preferences.isDarkMode = selectDark;
    _themeSubject.sink.add(_selectTheme);
  }
}
