
import 'package:applogin/main.dart';
import 'package:flutter/material.dart';

class ButtonGreen extends StatelessWidget {

  final String texto;
  final VoidCallback onPressed;

  const ButtonGreen({ 
    Key? key, 
    required this.texto, 
    required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(          
            top: 30.0,
            left: 20.0,
            right: 20.0,
            bottom: 20.0
        ),
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            colors: [
              
              MyApp.themeNotifier.value == ThemeMode.light?Color(0xFF8A2387):Color.fromARGB(255, 58, 15, 56),
              MyApp.themeNotifier.value == ThemeMode.light?Color(0xFFE94057):Color.fromARGB(255, 128, 35, 47),
              MyApp.themeNotifier.value == ThemeMode.light?Color(0xFFF27121):Color.fromARGB(255, 131, 62, 19),
            ],
            begin: Alignment.center,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp

          )
        ),
        child: Center(
          child: Text(
            texto,
            style:TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}