
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PageSplash extends StatefulWidget{
  const PageSplash({ Key? key }) : super(key: key);

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "UNIVERSALES",
          style: TextStyle(
            fontSize: 30
          ),
        ),
      ),
    );
  }
}