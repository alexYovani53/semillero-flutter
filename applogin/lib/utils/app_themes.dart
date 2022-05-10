import 'package:flutter/material.dart';

class AppThemes {

  static final ThemeData claro = 
    ThemeData(
      brightness: Brightness.light,
      primaryColor: Color.fromARGB(255, 179, 208, 231),
      primaryColorLight: Colors.orange,
      primaryColorDark: Colors.blue,

      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.green
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );

  static final ThemeData obscuro = 
    ThemeData(
          // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Color.fromARGB(255, 243, 1, 1),
      primaryColorLight: Color.fromARGB(255, 163, 98, 6),
      primaryColorDark: Color.fromARGB(255, 180, 2, 56),

      backgroundColor: Color.fromARGB(255, 73, 0, 0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 101, 129, 102)
      ),
      
      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme:  TextTheme(
      
        headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 170, 5, 5)),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        
      )
    );

  static const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

static const Color shrinePink50 = Color(0xFFFEEAE6);
static const Color shrinePink100 = Color(0xFFFEDBD0);
static const Color shrinePink300 = Color(0xFFFBB8AC);
static const Color shrinePink400 = Color(0xFFEAA4A4);

static const Color shrineBrown900 = Color(0xFF442B2D);
static const Color shrineBrown600 = Color(0xFF7D4F52);

static const Color shrineErrorRed = Color(0xFFC5032B);

static const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
static const Color shrineBackgroundWhite = Colors.white;

static const defaultLetterSpacing = 0.03;


}