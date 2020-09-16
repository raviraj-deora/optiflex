
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final String PF_USER_LOGIN = "login";
  static final String PF_GET_CONTENT = "getContent";
  static final String PF_CATEGORY = "category";

  static Future<bool> setString(String key, String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, data);
  }

  static Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> setBool(String key, bool data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, data);
  }

  static Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------


  static Future<bool> setInteger(String key, int data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, data);
  }

  static Future<int> getInteger(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }
}