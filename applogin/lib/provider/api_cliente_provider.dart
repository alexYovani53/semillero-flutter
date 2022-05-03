

import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiClienteProvider{

  ApiClienteProvider._privateConstructor();
  
  static final ApiClienteProvider shared = ApiClienteProvider._privateConstructor();

  Future<ClienteList> getAll( ) async{

    ClienteList clientList;
    
    if (MyApp.connected){

      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");
      final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/cliente/GetAll", type: HttpType.GET );

      if( response == null) {
        return  ClienteList.fromDefault();
      }
      clientList = ClienteList.fromList(response);

      ClienteRepository.shared.truncate(tableName: "cliente");
      ClienteRepository.shared.save(data: clientList.clientes, tableName: "cliente");


    }else{
      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
       final List<dynamic> clientesData = await ClienteRepository.shared.selectAll(tableName: "cliente");
       clientList = ClienteList.fromDb(clientesData);
    }

    return clientList;
  }

  Future<dynamic> guardarCliente(Map<String, dynamic> body) async {

    final ClienteNuevo = Cliente.fromServiceSpring(body);

    if (MyApp.connected){

      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");
      final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/cliente/Post", type: HttpType.POST,bodyParams: body);
      return response;                         

    }else{
      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
       final response = await ClienteRepository.shared.save(data: [ClienteNuevo], tableName:"cliente");
       return true;
    }                       

  }

  Future<dynamic> eliminarCliente(int dniCl) async {

    if (MyApp.connected){

      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A API");             
      final response =  await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: 'cliente/Delete/$dniCl', type: HttpType.DELETE);
      if( response == null) {
        return 0;
      }
      return response;                         

    }else{
      
      print(">>>>>>>>>>>>>>>>>>>>>>> PETICION A LOCAL");
      
      final response =  await ClienteRepository.shared.deleteWhere(tableName: "cliente",whereClause: "dniCl = ?",whereArgs: ['$dniCl']);  
                        
       return response;
    }                       

  }




}