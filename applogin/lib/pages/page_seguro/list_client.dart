
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/pages/page_client/client_view.dart';
import 'package:applogin/pages/page_seguro/Seguro_view.dart';
import 'package:flutter/material.dart';

class ListSeguro extends StatelessWidget {
    
  SeguroList listaSeguros;
  Function(Seguro seguro) navegar;

  ListSeguro({    
    required this.listaSeguros,
    required this.navegar
  });


  @override
  Widget build(BuildContext context) {

    List<Widget> lista = [];

    for (var seguro in listaSeguros.seguros) {
      lista.add( SeguroView(
          seguro: seguro,
          navegar: navegar
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lista
    );
  }
}