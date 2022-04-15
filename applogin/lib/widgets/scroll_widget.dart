

import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {

  final Widget child;

  ScrollWidget({ 
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(          
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child:child
      )
    );
  }
}