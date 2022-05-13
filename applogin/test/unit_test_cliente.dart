

import 'dart:io';

import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:flutter/cupertino.dart';
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
    await ClienteRepository.shared.deleteWhere(tableName: "cliente",whereClause: "nombreCl=?",whereArgs: ["alex"]);
    final result = await ClienteRepository.shared.selectAll(tableName: "cliente");

    expect(result, allOf([
      isNot(contains(data))
    ]));
  }); 
  
}