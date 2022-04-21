
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/model/siniestro/siniestro_list.dart';
import 'package:applogin/pages/page_client/client_view.dart';
import 'package:applogin/pages/page_seguro/Seguro_view.dart';
import 'package:applogin/pages/page_siniestro/Siniestro_view.dart';
import 'package:flutter/material.dart';

class ListSiniestro extends StatelessWidget {
    
  SiniestroList listaSiniestros;

  ListSiniestro({    
    required this.listaSiniestros
  });


  @override
  Widget build(BuildContext context) {

    List<Widget> lista = [];

    for (var siniestro in listaSiniestros.siniestros) {
      lista.add( SiniestroView(siniestro: siniestro));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lista
    );
  }
}