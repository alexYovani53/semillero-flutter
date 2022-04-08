import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {

  String title = "Popular";
  double? height;
  
  GradientBack({ 
    Key? key,
    this.title="",
    this.height }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    height ??= screenHeight;

    return Container(
      height: screenHeight,
      decoration: const BoxDecoration(
        gradient:  LinearGradient(
            stops: [
                    0.10, 
                    0.46, 
                    0.62, 
                    0.84, 
                    0.90, 
                    ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
                  Color(0xFF00B4DB), 
                  Color(0xFF00A4DB), 
                  Color(0xFF0094DB), 
                  Color(0xFF0084DB), 
                  Color(0xFF0073B0), 
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
            color:Color.fromRGBO(0, 0, 0, 0.05),
            borderRadius: BorderRadius.circular(screenWidth/2)
          ),
        ),
      ),
      
      alignment: Alignment(-0.9, -0.6),
    );
  }
}