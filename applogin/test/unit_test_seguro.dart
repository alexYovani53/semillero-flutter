
import 'dart:io';

import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/repository/seguro_repository.dart';
import 'package:flutter/foundation.dart';
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

void main(){

  sqfliteTestInit();
  
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
    await SeguroRepository.shared.save(data: [seguro], tableName: "seguros");
    await SeguroRepository.shared.deleteWhere(tableName: "cliente",whereClause: "nombreCl=?",whereArgs: ["322"]);
    final result = await SeguroRepository.shared.selectAll(tableName: "seguros");

    expect(result.length,isNot(0));
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

}