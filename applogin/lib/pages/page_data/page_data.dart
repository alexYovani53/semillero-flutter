
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter/material.dart';

class PageDAta extends StatelessWidget {
  const PageDAta({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:ApiManager.shared.request(baseUrl: "3.19.244.228:8585", uri: "/cliente/GetAll", type: HttpType.GET ),
        builder: (BuildContext context, snapshot){
          if (snapshot.hasData){
            final ClienteList client = snapshot.requireData as ClienteList;
            print('Si tine data: ${client.clientes[0].apellido1} ');
          }
          
          print('no tiene data');
          return Container();
        }
      )
    );
  }
}