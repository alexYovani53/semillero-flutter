import 'dart:io';
import 'package:applogin/utils/app_preferences.dart';
import 'package:flutter/cupertino.dart';

class LanguajeProvider with ChangeNotifier{

  static Locale? _locale;

  Future<Locale> getLocaleinit() async {
    final String? savedCodeLanguaje = await AppPreferences.shared.getString(AppPreferences.APP_LANGUAJE);
    print(savedCodeLanguaje);
    if(savedCodeLanguaje != null){
      _locale = Locale(savedCodeLanguaje);
      return Locale(savedCodeLanguaje);
    }else{
      _locale = Locale(Platform.localeName.substring(0,2));
      return _locale!;
    }
  }

  Locale get getLanguaje{
    if(_locale == null){
      getLocaleinit();
    }
    return  _locale!;
  }

  set setLanguaje (Locale newLang){
    print(newLang.languageCode);
    _locale = newLang;
    AppPreferences.shared.setString(AppPreferences.APP_LANGUAJE, newLang.languageCode);
    notifyListeners();
  }

}