import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static Future<void> setString(
      {required String key, required String value}) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(key, value);
  }

  static Future<String?> getString({required String key}) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getString(key);
  }

  static Future<void> setBoolean(
      {required String key, required bool value}) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(key, value);
  }

  static Future<bool?> getBoolean({required String key}) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(key);
  }

  static Future<bool> removeKeyPrefs({required String key}) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.remove(key);
  }

  static Future<void> setDouble(
      {required String key, required double value}) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setDouble(key, value);
  }

  static Future<double?> getDouble({required String key}) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getDouble(key);
  }
}