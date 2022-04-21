
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/pages/page_client/client_view.dart';
import 'package:applogin/pages/page_seguro/Seguro_view.dart';
import 'package:flutter/material.dart';

class ListSeguro extends StatelessWidget {
    
  SeguroList listaSeguros;

  ListSeguro({    
    required this.listaSeguros
  });


  @override
  Widget build(BuildContext context) {

    List<Widget> lista = [];

    for (var seguro in listaSeguros.seguros) {
      lista.add( SeguroView(seguro: seguro));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lista
    );
  }
}