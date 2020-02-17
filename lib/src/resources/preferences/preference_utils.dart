import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static Future<bool> setBool(String key,
      {bool value, SharedPreferences prefs}) async {
    return (prefs ?? await SharedPreferences.getInstance()).setBool(key, value);
  }

  static Future<bool> getBool(
    String key, {
    SharedPreferences prefs,
    bool def = false,
  }) async {
    try {
      return (prefs ?? await SharedPreferences.getInstance()).getBool(key) ??
          def;
    } on Exception catch (_) {
      return def;
    }
  }
}
