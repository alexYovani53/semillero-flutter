
import 'package:applogin/utils/app_preferences.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {

  static ThemeMode? _actual; 


  Future<ThemeMode> getInitTheme() async {
    final String? savedTheme = await AppPreferences.shared.getString(AppPreferences.APP_THEME);
    if(savedTheme != null){
      
    print(savedTheme);
      if (savedTheme == "claro"){
        return ThemeMode.light;
      }else{
        return ThemeMode.dark;
      }
    }

    return ThemeMode.light;
  }



  ThemeMode get getTheme {
    if(_actual == null) getInitTheme();
    return _actual!;
  }

  set setTheme(ThemeMode modo){
    _actual = modo;    
    print(modo.toString());
    AppPreferences.shared.setString(AppPreferences.APP_THEME,modo == ThemeMode.light?"claro":"obscuro");
    notifyListeners();
  }

}