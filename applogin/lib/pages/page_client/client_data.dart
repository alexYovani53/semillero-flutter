

import 'package:applogin/bloc/cliente_bloc/cliente_bloc.dart';
import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ClientData extends StatelessWidget {

  Cliente cliente;
  ClientData({ 
    Key? key,
    required this.cliente
  }) : super(key: key);

  Widget getRow(String text){
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(                
                margin: EdgeInsets.only(top: 6.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade900),
                  )
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 30.0
                  ),
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ClienteBloc(),
      child: BlocListener<ClienteBloc,ClienteState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case EliminarClienteState:
              Navigator.pop(context,{"eliminado":cliente.dniCl});
              break;
            default:
          }
        },
        child: BlocBuilder<ClienteBloc,ClienteState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(cliente.nombreCl)
              ),
              body: Container(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getRow(cliente.nombreCl),
                  getRow(cliente.apellido1 + " " + cliente.apellido2),
                  getRow(cliente.ciudad),
                  getRow(cliente.claseVia),
                  getRow(cliente.nombreVia),
                  getRow(cliente.observaciones),
                  getRow(cliente.codPostal.toString()),
                  getRow(cliente.dniCl.toString()),
                  getRow(cliente.telefono.toString()),
                  IconButton(
                    color: Colors.black87,
                    icon: const Icon(Icons.delete),
                    onPressed: ()async{

                        BlocProvider.of<ClienteBloc>(context).add(ElimnarClienteEvent(dniCl: cliente.dniCl));
           
                  })
                  
                ],
              ),
              )
            );
          },
        ),
      ),
    );
  }
}