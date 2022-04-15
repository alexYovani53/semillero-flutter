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

}