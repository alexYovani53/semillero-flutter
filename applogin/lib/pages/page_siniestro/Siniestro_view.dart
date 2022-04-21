
import 'dart:convert';

import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/pages/page_client/client_data.dart';
import 'package:applogin/pages/page_seguro/Seguro_data.dart';
import 'package:applogin/pages/page_siniestro/Siniestro_data.dart';
import 'package:flutter/material.dart';

class SiniestroView extends StatefulWidget {
  
  Siniestro siniestro;

  SiniestroView({    
    required this.siniestro
  });


  @override
  State<SiniestroView> createState() => _SiniestroViewState();
}

class _SiniestroViewState extends State<SiniestroView> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5.0,
        left: 10.0,
        right:10.0
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.00)),
        gradient:  LinearGradient(
            stops: [
                    0.50, 
                    0.99, 
                    ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
                  MyApp.themeNotifier.value == ThemeMode.light? Color(0xFFcac531):Color(0xFF485563),
                  MyApp.themeNotifier.value == ThemeMode.light? Color(0xFFf3f9a7):Color(0xFF29323C),
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
                  image: AssetImage("assets/images/cliente.png")
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
                    widget.siniestro.fechaSiniestro.toString(),
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
                    widget.siniestro.causas,
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
                    "Perito: "+widget.siniestro.dniPerito.toString(),
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
                  heroTag: widget.siniestro.idSiniestro,
                  child:  Icon(
                    Icons.arrow_forward,
                    size: 50.0,
                  ),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(
                      builder: (ctx)=> SiniestroData(siniestro: widget.siniestro)
                    ));
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