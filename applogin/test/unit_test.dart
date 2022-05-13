import 'dart:io';

import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/provider/api_siniestro_provider.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/repository/db_manager.dart';
import 'package:applogin/repository/seguro_repository.dart';
import 'package:applogin/repository/siniestro_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


/// Initialize sqflite for test.
void sqfliteTestInit() async{
  // Initialize ffi implementation
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }
  // Set global factory
 databaseFactory = databaseFactoryFfi;
}

void main() {
  sqfliteTestInit();


  test('Eliminación de base de datos', () async {
    final dbManager = DbManager();
    final result = await dbManager.deleteDb();
    expect( result, true);

  });

   test('Creación de base de datos.', () async {
    DbManager.shared.deleteDb();
    final result = await DbManager.shared.initDb();
    debugPrint(result.path);
    
    expect( result.isOpen, true);
  });

  test('Obtener * de tabla clientes', () async {

    final data = {
      "dniCl": 322,
      "nombreCl": "alex",
      "apellido1": "a",
      "apellido2": "a",
      "claseVia": "a",
      "numeroVia": 3,
      "codPostal": 3,
      "ciudad": "Guatemala",
      "telefono": 444,
      "observaciones": "aaaa",
      "nombreVia": "a"
    };
    
    final cliente = Cliente.fromServiceSpring(data);
    await ClienteRepository.shared.save(data: [cliente], tableName: "cliente");
    final result = await ClienteRepository.shared.selectAll(tableName: "cliente");

    expect(result.length,isNot(0));
  });


  test('Eliminar de tabla clientes', () async {

    final data = {
      "dniCl": 322,
      "nombreCl": "alex",
      "apellido1": "a",
      "apellido2": "a",
      "claseVia": "a",
      "numeroVia": 3,
      "codPostal": 3,
      "ciudad": "Guatemala",
      "telefono": 444,
      "observaciones": "aaaa",
      "nombreVia": "a"
    };
    
    final cliente = Cliente.fromServiceSpring(data);
    await ClienteRepository.shared.save(data: [cliente], tableName: "cliente");
    await ClienteRepository.shared.deleteWhere(tableName: "cliente",whereClause: "nombreCl=?",whereArgs: ["322"]);
    final result = await ClienteRepository.shared.selectAll(tableName: "cliente");

    expect(result.length,equals(0));
  }); 
  

  
  
  test('Obtener * de tabla seguros', () async {

    final data = {
      "numeroPoliza": 303,
      "ramo": "fecha",
      "fechaInicio": "2022-04-28",
      "fechaVencimiento": "2022-04-30",
      "condicionesParticulares": "ffffffffffff",
      "dniCl": 285      
    };

    final seguro = Seguro.fromServiceSpring(data);
    await SeguroRepository.shared.save(data: [seguro],tableName: "seguros");
    final result = await SeguroRepository.shared.selectAll(tableName: "seguros");

    expect(result.length,isNot(0));
  });

  test('Eliminar de tabla seguros', () async {

    final data = {
      "numeroPoliza": 303,
      "ramo": "fecha",
      "fechaInicio": "2022-04-28",
      "fechaVencimiento": "2022-04-30",
      "condicionesParticulares": "ffffffffffff",
      "dniCl": 285      
    };
    
    final seguro = Seguro.fromServiceSpring(data);
    await SeguroRepository.shared.save(data: [seguro], tableName: "seguro");
    await SeguroRepository.shared.deleteWhere(tableName: "cliente",whereClause: "nombreCl=?",whereArgs: ["322"]);
    final result = await SeguroRepository.shared.selectAll(tableName: "seguro");

    expect(result.length,isNot(0));
  });
  test('Mapear objeto a modelo Cliente',(){

    final data = {
      "dniCl": 322,
      "nombreCl": "alex",
      "apellido1": "a",
      "apellido2": "a",
      "claseVia": "a",
      "numeroVia": 3,
      "codPostal": 3,
      "ciudad": "Guatemala",
      "telefono": 444,
      "observaciones": "aaaa",
      "nombreVia": "a"
    };

    final cliente = Cliente.fromServiceSpring(data);
    expect(cliente.ciudad, "Guatemala");
    debugPrint('Prueba finalizada con exito');

  });
  
  test('Mapear objeto a modelo Seguro',(){

    final data = {
      "numeroPoliza": 303,
      "ramo": "fecha",
      "fechaInicio": "2022-04-28",
      "fechaVencimiento": "2022-04-30",
      "condicionesParticulares": "ffffffffffff",
      "dniCl": 285      
    };

    final seguro = Seguro.fromServiceSpring(data);
    expect(seguro.fechaInicio, equals(DateTime.parse("2022-04-28")));
    debugPrint('Prueba finalizada con exito');
  });



test('Mapear objeto a modelo siniestro',(){
    final data = {
        "idSiniestro": 143,
        "fechaSiniestro": "2022-03-10T00:00:00.000+00:00",
        "causas": "Incendio",
        "aceptado": "no",
        "indemnizacion": 15000,
        "numeroPoliza": 303,
        "dniPerito": 67
    };

    final siniestro = Siniestro.fromServiceSpring(data);
    expect(siniestro.fechaSiniestro,equals(DateTime.parse("2022-03-10T00:00:00.000+00:00")));


  });

  
  test('Obtener * de tabla siniestros', () async {

    final data = {
      "idSiniestro": 143,
      "fechaSiniestro": "2022-03-10T00:00:00.000+00:00",
      "causas": "Incendio",
      "aceptado": "no",
      "indemnizacion": 15000,
      "numeroPoliza": 303,
      "dniPerito": 67
    };
    
    final siniestro = Siniestro.fromServiceSpring(data);
    await SiniestroRepository.shared.save(data: [siniestro], tableName: "siniestros");
    final result = await SiniestroRepository.shared.selectAll(tableName: "siniestros");

    expect(result.length,isNot(0));
  });


  test('Eliminar de tabla siniestros', () async {
    final data = {
      "idSiniestro": 143,
      "fechaSiniestro": "2022-03-10T00:00:00.000+00:00",
      "causas": "Incendio",
      "aceptado": "no",
      "indemnizacion": 15000,
      "numeroPoliza": 303,
      "dniPerito": 67
    };
    
    final siniestro = Siniestro.fromServiceSpring(data);
    await SiniestroRepository.shared.save(data: [siniestro], tableName: "siniestros");
    await SiniestroRepository.shared.deleteWhere(tableName: "siniestros",whereClause: "numeroPoliza=?",whereArgs: ["303"]);
    final result = await SiniestroRepository.shared.selectAll(tableName: "siniestros");

    expect(result.length,equals(0));
  }); 
  
    test('Eliminar de tabla siniestros ApiProvider', () async {
    MyApp.connected = false;
    final data = {
      "idSiniestro": 143,
      "fechaSiniestro": "2022-03-10T00:00:00.000+00:00",
      "causas": "Incendio",
      "aceptado": "no",
      "indemnizacion": 15000,
      "numeroPoliza": 303,
      "dniPerito": 67
    };
    
    await ApiSiniestroProvider.shared.guardarSiniestro(data);
    await SiniestroRepository.shared.deleteWhere(tableName: "siniestros",whereClause: "numeroPoliza=?",whereArgs: ["303"]);
    final result = await SiniestroRepository.shared.selectAll(tableName: "siniestros");

    expect(result.length,equals(0));
  }); 


}