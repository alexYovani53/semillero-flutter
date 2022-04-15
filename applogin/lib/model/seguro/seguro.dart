import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Seguro {

  late int numeroPoliza ;
  late int dniCl;
  late DateTime fechaInicio;
  late DateTime fechaVencimiento;
  late String condicionesParticulares;
  late String ramo;

  Seguro.fromServiceSpring(Map<String,dynamic> data){

    numeroPoliza = data['numeroPoliza'];
    ramo = data['ramo'];
    fechaInicio = DateTime.parse(data['fechaInicio']);
    fechaVencimiento = DateTime.parse(data['fechaVencimiento']);
    condicionesParticulares = data['condicionesParticulares'];
    dniCl = data['dniCl'];
  }

}