

import 'dart:convert';

import 'package:applogin/bloc/basic_bloc.dart';
import 'package:applogin/main.dart';
import 'package:applogin/repository/realtime_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeButton extends StatelessWidget {
  

  final realtime = RealTimeRepository();

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
      stream:realtime.stream() ,
      builder: (context, AsyncSnapshot snapshot)  {

        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
                      
            final estado = snapshot.data.snapshot.value['theme'] as String;
            print(estado);


            if (estado == "claro"){
              MyApp.themeNotifier.value == ThemeMode.dark;
            }else{
              MyApp.themeNotifier.value == ThemeMode.light;
            }

            return appBar(snapshot);
          default:
            return const CircularProgressIndicator();
        }

        

      },
    );
  }

  Widget appBar(AsyncSnapshot snapshot){

    final estado = snapshot.data.snapshot.value['theme'] as String;
    
    return  
    IconButton(
      icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
          ? Icons.dark_mode
          : Icons.light_mode),
      onPressed: () {
        realtime.updateThemeMode();
        MyApp.themeNotifier.value =
            MyApp.themeNotifier.value == ThemeMode.light
                ? ThemeMode.dark
                : ThemeMode.light;
      });
              
  }

}