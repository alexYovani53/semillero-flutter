
import 'package:applogin/main.dart';
import 'package:applogin/pages/page_client/page_client.dart';
import 'package:applogin/pages/page_seguro/page_seguro.dart';
import 'package:applogin/pages/page_siniestro/page_siniestro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CuppertinoBar extends StatelessWidget {
  const CuppertinoBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 35.0,  
          activeColor: Colors.green,
          border: Border(top: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.indigo.shade900:Colors.white)),

          items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.emoji_people,
                    color: MyApp.themeNotifier.value == ThemeMode.light? Color.fromARGB(255, 8, 8, 8):Color.fromARGB(255, 220, 221, 223),                  
                  )
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_moderator,
                    color: MyApp.themeNotifier.value == ThemeMode.light? Color.fromARGB(255, 8, 8, 8):Color.fromARGB(255, 220, 221, 223),                  
                  )
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dangerous, 
                  color: MyApp.themeNotifier.value == ThemeMode.light? Color.fromARGB(255, 8, 8, 8):Color.fromARGB(255, 220, 221, 223),                  
                )
              ),
          ],
        ) , 
        tabBuilder: (BuildContext context, int index){
          switch (index) {
            case 0:
              return PageClient();
            case 1:
              return  PageSeguro();
            case 2:
              return  PageSiniestro();
            default:
              return PageClient();
          }
        }
      )
    );
  }
}