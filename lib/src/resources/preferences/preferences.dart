import 'package:unofficial_conference_app_2020/src/resources/preferences/preference_utils.dart';

class Preferences {
  Preferences._();

  static const fIsDarkMode = 'isDarkMode';

  // isDarkMode
  static set isDarkMode(bool value) =>
      PrefUtils.setBool(fIsDarkMode, value: value);

  static Future<bool> get isDarkMode async => PrefUtils.getBool(fIsDarkMode);
}
