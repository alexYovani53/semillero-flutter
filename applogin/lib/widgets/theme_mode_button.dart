
import 'package:applogin/main.dart';
import 'package:applogin/provider/themeProvider.dart';
import 'package:applogin/repository/firebase/realtime_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeModeButton extends StatelessWidget {
  

  final realtime = RealTimeRepository();

  @override
  Widget build(BuildContext context) {

    final ThemeProvider theme =Provider.of<ThemeProvider>(context);
    
    return StreamBuilder(
      stream:realtime.stream() ,
      builder: (context, AsyncSnapshot snapshot)  {

        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
                      
            final estado = snapshot.data.snapshot.value['theme'] as String;
            print(estado);


            if (estado == "claro"){
              theme.setTheme = ThemeMode.dark;
            }else{
              theme.setTheme = ThemeMode.light;
            }

            return appBar(snapshot,theme);
          default:
            return const CircularProgressIndicator();
        }

        

      },
    );
  }

  Widget appBar(AsyncSnapshot snapshot, ThemeProvider theme){

    final estado = snapshot.data.snapshot.value['theme'] as String;
    
    return  
    IconButton(
      icon: Icon(theme.getTheme == ThemeMode.light
          ? Icons.dark_mode
          : Icons.light_mode),
      onPressed: () {
        realtime.updateThemeMode();
        theme.setTheme =
            theme.getTheme == ThemeMode.light
                ? ThemeMode.dark
                : ThemeMode.light;
      });
              
  }

}