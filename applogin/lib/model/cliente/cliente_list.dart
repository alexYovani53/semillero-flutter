
import 'package:applogin/model/cliente/cliente.dart';

class ClienteList {


  late List<Cliente> clientes;

  ClienteList.fromList(List<dynamic> data){
    clientes = [];

    for (var item in data) {
      clientes.add(Cliente.fromServiceSpring(item));
    }

  }

  ClienteList.fromDefault(){
    clientes = [];
  }
  

}