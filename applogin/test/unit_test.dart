import 'dart:io';
import 'package:applogin/bloc/basic_bloc/basic_bloc.dart';
import 'package:applogin/provider/api_local_auth.dart';
import 'package:applogin/repository/db_manager.dart';
import 'package:bloc_test/bloc_test.dart';
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
  TestWidgetsFlutterBinding.ensureInitialized();
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

  // test('biometria',()async {
  
  //   bool biometria = await ApiLocalAuth.shared.hasBiometrics();
  //   expect(biometria, true);
  // });

  
  
  group("block", (){

    blocTest(
      "description", 
      build: ()=>BasicBloc(),
      act:(BasicBloc bloc)=> bloc.add(ButtonPressedEvent()),
      expect: ()=>[isA<LogExitosoState>()],
    );

  }); 




}