import 'dart:io';

import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/repository/db_manager.dart';
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


  test('Delete db on device', () async {
    final dbManager = DbManager();
    final result = await dbManager.deleteDb();
    expect( result, true);

  });

   test('Create db on device', () async {
    DbManager.shared.deleteDb();
    final result = await DbManager.shared.initDb();

    debugPrint(result.path);

    expect( result.isOpen, true);
  });

  test('Get all of table cliente', () async {
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
    
    
    await ClienteRepository.shared.save(data: [data], tableName: "cliente");
    final result = await ClienteRepository.shared.selectAll(tableName: "cliente");
    print(result.length);
    expect(result.length,0);
  });

  
  test('Get all of table seguro', () async {
    final result = await ClienteRepository.shared.selectAll(tableName: "seguros");
    print(result.length);
    expect(result.length,0);
  });

  test('map customers',(){

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

}