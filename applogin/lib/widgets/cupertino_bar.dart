
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
          activeColor: Colors.green,
          items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_people,color: Colors.indigo),
                  label: ""
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_moderator, color: Colors.indigo),
                  label: ""
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dangerous, color: Colors.indigo),
                  label: ""
              ),
          ],
        ) , 
        tabBuilder: (BuildContext context, int index){
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context){
                  return PageClient();
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context){
                  return PageSeguro();
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context){
                  return PageSiniestro();
                },
              );
            default:
              return CupertinoTabView(
                builder: (BuildContext context){
                  return PageClient();
                },
              );
          }
        }
      )
    );
  }
}