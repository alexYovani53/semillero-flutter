import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {

  String? title;
  double? height;
  bool login;
  
  GradientBack({ 
    Key? key,
    this.title,
    this.height,
    this.login = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    height ??= screenHeight;


    if (login) {
      return backGround(height??screenHeight, screenWidth);
    } 

    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient:  LinearGradient(
            stops: [
                    0.50, 
                    0.90, 
                    ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
                  Color.fromRGBO(167,220,225,1), 
                  Color.fromRGBO(28, 13, 138, 255), 
                  ],
          )
      ),
      child: FittedBox(
        fit:BoxFit.none,
        alignment: Alignment(-1.5,-0.8),
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            color:Color.fromRGBO(0, 0, 0, 0.03),
            borderRadius: BorderRadius.circular(screenWidth/2)
          ),
        ),
      ),
      
      alignment: Alignment(-0.9, -0.6),
    );
  
  }

  Widget backGround(double screenHeight, double screenWidth){
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/top1.png',
              // color: Colors.blue,
              width: screenWidth,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/top2.png',
              // color: Colors.blueAccent,
              width: screenWidth,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bottom1.png',
              width: screenWidth,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bottom2.png',
              width: screenWidth,
            ),
          ),
        ],
      ),
    );
  }

}