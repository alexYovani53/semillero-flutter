import 'dart:io';
import 'package:applogin/bloc/basic_bloc/basic_bloc.dart';
import 'package:applogin/bloc/cliente_bloc/cliente_bloc.dart';
import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/provider/api_local_auth.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/repository/db_manager.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  
  
  group("bloc ", (){

    blocTest(
      "bloc  --> evento ButtonPressedEvent", 
      build: ()=>BasicBloc(),
      act:(BasicBloc bloc)=> bloc.add(ButtonPressedEvent()),
      expect: ()=>[LogExitosoState(logeado: true, title: "Hola mundo")],
    );


    blocTest(
      "bloc  --> evento LoginEvent", 
      build: ()=>BasicBloc(),
      act:(BasicBloc bloc)=> bloc.add(LoginEvent(data: "AlexYovani")),
      expect: ()=>[LogExitosoState(logeado: true, title:"AlexYovani")],

    );

    blocTest(
      "bloc  --> evento LogOutEvent", 
      build: ()=>BasicBloc(),
      act:(BasicBloc bloc)=> bloc.add(LogOutEvent()),
      expect: ()=>[LogOutState(logeado: false)],

    );

    debugPrint("Finalizado");
    

  }); 


  test('Can Create Preferences', () async{

    SharedPreferences.setMockInitialValues({
      "key": "value"
    }); //set values here
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool working = false;
    String name = 'john';
    pref.setBool('working', working);
    pref.setString('name', name);


    expect(pref.getBool('working'), false);
    expect(pref.getString('name'), 'john');
  });


}

/*
void main(){
  SharedPreferences? preference;
  LocalDataSourceImp? localStorage ;

setUp(() async{
  preference =  await SharedPreferences.getInstance();
  localStorage = LocalDataSourceImp(preference!);
  SharedPreferences.setMockInitialValues({});
});

final token = TokenModel(data: "babakoto");

test("cache Token ", ()async{
  localStorage!.cacheToken(token);
  final result = preference!.getString(TOKEN);
  expect(result, json.encode(token.toJson()));
});
}*/