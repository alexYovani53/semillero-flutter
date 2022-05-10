import 'package:applogin/pages/page_client/page_client.dart';
import 'package:applogin/pages/page_seguro/page_seguro.dart';
import 'package:applogin/pages/page_siniestro/page_siniestro.dart';
import 'package:applogin/provider/themeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CuppertinoBar extends StatelessWidget {
  const CuppertinoBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeProvider theme =Provider.of<ThemeProvider>(context);
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          iconSize: 35.0,  
          activeColor: Colors.green,
          border: Border(top: BorderSide(color: theme.getTheme == ThemeMode.light? Color.fromARGB(255, 2, 8, 73):Colors.white)),

          items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.emoji_people,
                    color: theme.getTheme == ThemeMode.light? Color.fromARGB(255, 8, 8, 8):Color.fromARGB(255, 220, 221, 223),                  
                  )
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_moderator,
                    color: theme.getTheme == ThemeMode.light? Color.fromARGB(255, 8, 8, 8):Color.fromARGB(255, 220, 221, 223),                  
                  )
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dangerous, 
                  color: theme.getTheme == ThemeMode.light? Color.fromARGB(255, 8, 8, 8):Color.fromARGB(255, 220, 221, 223),                  
                )
              ),
          ],
        ) , 
        tabBuilder: (BuildContext context, int index){
          // switch (index) {
          //   case 0:
          //     return CupertinoTabView(builder: (BuildContext context) {                
          //       return PageClient();
          //     });
          //   case 1:
          //     return CupertinoTabView(builder: (BuildContext context) {                
          //       return PageSeguro();
          //     });
          //   case 2:
          //     return CupertinoTabView(builder: (BuildContext context) {                
          //       return PageSiniestro();
          //     });
          //   default:
          //     return CupertinoTabView(builder: (BuildContext context) {                
          //       return PageClient();
          //     });
          // }
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