

import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/model/siniestro/siniestro_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/repository/siniestro_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiSiniestroProvider{

  ApiSiniestroProvider._privateConstructor();
  
  static final ApiSiniestroProvider shared = ApiSiniestroProvider._privateConstructor();

  Future<SiniestroList> getAll( ) async{

    SiniestroList siniestroList;
    
    if (MyApp.connected){

      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");
      final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/siniestros/getAll", type: HttpType.GET );

      if( response == null) {
        return  SiniestroList.fromDefault();
      }
      siniestroList = SiniestroList.fromList(response);
      
      SiniestroRepository.shared.truncate(tableName: "siniestros");
      SiniestroRepository.shared.save(data: siniestroList.siniestros, tableName: "siniestros");


    }else{
      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
       final List<dynamic> clientesData = await ClienteRepository.shared.selectAll(tableName: "siniestros");
       siniestroList = SiniestroList.fromDb(clientesData);
    }

    return siniestroList;
  }

  Future<dynamic> guardarSiniestro(Map<String, dynamic> body) async {

    final SiniestroNuevo = Siniestro.fromServiceSpring(body);

    if (MyApp.connected){

      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");
      final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/siniestros/post", type: HttpType.POST,bodyParams: body);
      return response;                         

    }else{
      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
       final response = await SiniestroRepository.shared.save(data: [SiniestroNuevo], tableName:"siniestros");
       return true;
    }                       

  }

  Future<dynamic> eliminarSiniestro(int idSiniestro) async {

    if (MyApp.connected){

      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");             
      final response =  await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: 'siniestros/delete/$idSiniestro', type: HttpType.DELETE);
                      
      if( response == null) {
        return 0;
      }
      return response;                         

    }else{
      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
      
      final response =  SiniestroRepository.shared.deleteWhere(tableName: "siniestros",whereClause: "idSiniestro = ?",whereArgs: ['$idSiniestro']);  
                        
                        
       return response;
    }                       

  }




}