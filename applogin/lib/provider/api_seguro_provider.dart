

import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/repository/seguro_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiSeguroProvider{

  ApiSeguroProvider._privateConstructor();  
  static final ApiSeguroProvider shared = ApiSeguroProvider._privateConstructor();

  Future<SeguroList> getAll( ) async{

    SeguroList seguroList;
    
    if (MyApp.connected){

      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");
      final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/seguros/GetAll", type: HttpType.GET );

      if( response == null) return  SeguroList.fromDefault();

      seguroList = SeguroList.fromList(response);      
      SeguroRepository.shared.truncate(tableName: "seguros");
      SeguroRepository.shared.save(data: seguroList.seguros, tableName: "seguros");

    }else{
      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
       final List<dynamic> segurosData = await SeguroRepository.shared.selectAll(tableName: "seguros");
       seguroList = SeguroList.fromDb(segurosData);
    }

    return seguroList;
  }

  Future<dynamic> guardarSeguro(Map<String, dynamic> body) async {

    final SeguroNuevo = Seguro.fromServiceSpring(body);

    if (MyApp.connected){
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");
      final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/seguros/Post", type: HttpType.POST,bodyParams: body);
      return response;                  
    }else{      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
       final response = await SeguroRepository.shared.save(data: [SeguroNuevo], tableName:"seguro");
       return true;
    }                       

  }

  Future<dynamic> eliminarSeguro(int numeroPoliza) async {
                      
    
    if (MyApp.connected){
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");             
      final response =  await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: 'seguros/Delete/$numeroPoliza', type: HttpType.DELETE);
      if( response == null) return 0;
      return response;                         
    }else{      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
      final response =  await SeguroRepository.shared.deleteWhere(tableName: "seguros",whereClause: "numeroPoliza = ?",whereArgs: ['$numeroPoliza']);                         
      return response;
    }                      
  }




}