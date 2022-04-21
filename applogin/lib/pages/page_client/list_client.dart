
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/pages/page_client/client_view.dart';
import 'package:flutter/material.dart';

class ListClient extends StatelessWidget {
    
  ClienteList listaCliente;

  ListClient({    
    required this.listaCliente
  });


  @override
  Widget build(BuildContext context) {

    List<Widget> lista = [];

    for (var client in listaCliente.clientes) {
      lista.add( ClientView(cliente: client));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lista
    );
  }
}