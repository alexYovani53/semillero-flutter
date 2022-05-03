
import 'package:applogin/model/usuario/usuario_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiLogin{

  ApiLogin._privateConstructor();  
  static final ApiLogin shared = ApiLogin._privateConstructor();

  Future<bool> ejecutarLogin(String correo, String password) async {
    Map<String,dynamic> parametros = <String,dynamic>{"correo":correo,"password":password} ;
    final data =  await ApiManager.shared.request(baseUrl:dotenv.env['BASE_URL']!, uri: 'usuario/login', type: HttpType.GET,uriParams:parametros);
    final lista = UsuarioList.fromList(data);

    if (lista.usuarios.isEmpty) return false;
    return true;

  }

  Future<bool> getError403() async {    
    final result =  await ApiManager.shared.request(baseUrl:dotenv.env['BASE_URL']!, uri: 'usuario/getfallo', type: HttpType.GET);
    if( result == 403) return true;
    return false;
  }



}