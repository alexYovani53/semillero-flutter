import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._privateConstructor();

  static final AppPreferences shared = AppPreferences._privateConstructor();
  
  static const APP_LANGUAJE = "LANGUAJE";
  static const APP_THEME = "THEME";
  static const APP_REMEMBER = "remember_me";
  static const APP_EMAIL = "email";
  static const APP_PASSWORD = "password";



  setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<bool> contains(String key) async {    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool?> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  
}
