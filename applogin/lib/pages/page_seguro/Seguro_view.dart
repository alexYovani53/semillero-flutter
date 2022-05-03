
import 'dart:convert';

import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/pages/page_client/client_data.dart';
import 'package:applogin/pages/page_seguro/Seguro_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeguroView extends StatefulWidget {
  
  Seguro seguro;
  Function(Seguro seguro) navegar;

  SeguroView({    
    required this.seguro,
    required this.navegar
  });


  @override
  State<SeguroView> createState() => _SeguroViewState();
}

class _SeguroViewState extends State<SeguroView> {


  @override
  Widget build(BuildContext context) {

    final DateFormat  formatter = DateFormat('yyyy-MM-dd');

      
    return Container(
      margin: const EdgeInsets.only(
        top: 5.0,
        left: 10.0,
        right:10.0
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.00)),
        gradient:  LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
                  MyApp.themeNotifier.value == ThemeMode.light? Color.fromARGB(255, 243, 237, 229):Color(0xFF485563),
                  MyApp.themeNotifier.value == ThemeMode.light? Color.fromARGB(255, 96, 231, 72):Color(0xFF29323C),
            ],
          )
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              top:5.0,
              left: 5.0,
              bottom: 5.0
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/seguros.png")
              )
            ),
            width: 80.0,
            height: 80.0
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0
                  ),
                  child: Text(
                    widget.seguro.numeroPoliza.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize:  17.0
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0
                  ),
                  child: Text(
                    formatter.format(widget.seguro.fechaInicio),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize:  12.0
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0
                  ),
                  child: Text(
                    widget.seguro.ramo,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize:  15.0
                    )
                  ),
                ),
              ],
            ),
          
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: FloatingActionButton(
                  heroTag: widget.seguro.numeroPoliza,
                  child:  Icon(
                    Icons.arrow_forward,
                    size: 50.0,
                  ),
                  onPressed: (){
                    widget.navegar(widget.seguro);
                  },
                ),
              ),
            ),
          )

        ],
      )
  
    );
  
  }
}