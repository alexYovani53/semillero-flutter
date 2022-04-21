

import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/siniestro_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SiniestroData extends StatelessWidget {

  Siniestro siniestro;

  SiniestroData({ 
    Key? key,
    required this.siniestro
  }) : super(key: key);

  Widget getRow(String text){
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(                
                margin: EdgeInsets.only(top: 6.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade900),
                  )
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 30.0
                  ),
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("No. "+siniestro.idSiniestro.toString())
      ),
      body: Container(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getRow(siniestro.idSiniestro.toString()),
          getRow(siniestro.causas),
          getRow(siniestro.aceptado),
          getRow(siniestro.dniPerito.toString()),
          getRow(siniestro.fechaSiniestro.toString()),
          getRow("Q. " + siniestro.indemnizacion.toString()),          
          getRow(siniestro.numeroPoliza.toString()),
          IconButton(
            color: Colors.black87,
            icon: const Icon(Icons.delete),
            onPressed: ()async{
              if(true ){
                SiniestroRepository.shared.deleteWhere(tableName: "siniestros",whereClause: "idSiniestro = ?",whereArgs: ['${siniestro.idSiniestro}']);  
                Navigator.pop(context);       
              }else{
                final data =  await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: 'cliente/Delete/${siniestro.idSiniestro}', type: HttpType.DELETE);
              }
              
          })
          
        ],
      ),
      )
    );
  }
}