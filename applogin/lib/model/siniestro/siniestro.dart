import 'package:flutter/material.dart';

class Siniestro {

  late int idSiniestro ;
  late int dniPerito;
  late int numeroPoliza;
  late int indemnizacion;

  late String causas;
  late String aceptado;
  late DateTime fechaSiniestro;

  Siniestro.fromServiceSpring(Map<String,dynamic> data){
    
    idSiniestro = data['idSiniestro'];
    causas = data['causas'];
    aceptado = data['aceptado'];
    fechaSiniestro = DateTime.parse( data['fechaSiniestro']) ;
    dniPerito = data['dniPerito'];
    numeroPoliza = data['numeroPoliza'];
    indemnizacion = data['indemnizacion'];
  }

  Siniestro.fromDb(Map<String,dynamic> data){
    
    idSiniestro = data['idSiniestro'];
    causas = data['causas'];
    aceptado = data['aceptado'];
    fechaSiniestro =DateTime.parse( data['fechaSiniestro']);
    dniPerito = data['dniPerito'];
    numeroPoliza = data['numeroPoliza'];
    indemnizacion = data['indemnizacion'];
  }


    Map<String, dynamic> toDatabase()=>{
      "idSiniestro" :idSiniestro,
      "causas" :causas,
      "aceptado" :aceptado,
      "fechaSiniestro" : fechaSiniestro.toString(),
      "dniPerito" :dniPerito,
      "numeroPoliza" : numeroPoliza,
      "indemnizacion" : indemnizacion
    };

}