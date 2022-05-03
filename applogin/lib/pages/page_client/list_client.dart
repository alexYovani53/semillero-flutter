
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/pages/page_client/client_view.dart';
import 'package:flutter/material.dart';

class ListClient extends StatelessWidget {
    
  ClienteList listaCliente;
  Function(Cliente client) navegar;

  ListClient({    
    required this.listaCliente,
    required this.navegar
  });


  @override
  Widget build(BuildContext context) {

    List<Widget> lista = [];

    for (var client in listaCliente.clientes) {
      lista.add( ClientView(cliente: client, navegar:navegar ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lista
    );
  }
}