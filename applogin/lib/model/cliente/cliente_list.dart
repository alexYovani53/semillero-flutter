
import 'package:applogin/model/cliente/cliente.dart';

class ClienteList {


  late List<Cliente> clientes;
  late List<dynamic> clientesToDatabase;

  ClienteList.fromList(List<dynamic> data){
    clientes = [];    
    for (var item in data) {
      clientes.add(Cliente.fromServiceSpring(item));
    }
  }

  ClienteList.fromDb(List<dynamic> data){
    clientes = [];    
    for (var item in data) {
      clientes.add(Cliente.fromDb(item));
    }
  }

  ClienteList.fromDefault(){
    clientes = [];
  }
  



}