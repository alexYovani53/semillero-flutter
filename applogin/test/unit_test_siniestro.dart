

// Initialize sqflite for test.
import 'dart:io';

import 'package:applogin/main.dart';
import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/provider/api_siniestro_provider.dart';
import 'package:applogin/repository/siniestro_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void sqfliteTestInit() async{
  // Initialize ffi implementation
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }
  // Set global factory
 databaseFactory = databaseFactoryFfi;
}
void main(){

  sqfliteTestInit();
  
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