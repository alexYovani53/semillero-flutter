

import 'package:applogin/bloc/seguro_bloc/seguro_bloc.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class SeguroData extends StatelessWidget {

  Seguro seguro;
  SeguroData({ 
    Key? key,
    required this.seguro
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


    // final SeguroBloc block = BlocProvider.of<SeguroBloc>(context);
    final DateFormat  formatter = DateFormat('yyyy-MM-dd');

    return BlocProvider(
      create: (context)=>SeguroBloc(),
      child: BlocListener<SeguroBloc,SeguroState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case EliminarSeguroState:
              Navigator.pop(context,{"eliminado":seguro.numeroPoliza});
              break;
            default:
          }
        },
        child: BlocBuilder<SeguroBloc,SeguroState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(seguro.numeroPoliza.toString())
              ),
              body: Container(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getRow(seguro.numeroPoliza.toString()),
                  getRow(seguro.ramo),
                  getRow(seguro.dniCl.toString()),
                  getRow(formatter.format(seguro.fechaInicio)),
                  getRow(formatter.format(seguro.fechaVencimiento)),
                  getRow(seguro.condicionesParticulares),
                  IconButton(
                    color: Colors.black87,
                    icon: const Icon(Icons.delete),
                    onPressed: ()async{
                      
                        //SeguroRepository.shared.deleteWhere(tableName: "seguros",whereClause: "numeroPoliza = ?",whereArgs: ['${seguro.numeroPoliza}']);  

                        BlocProvider.of<SeguroBloc>(context).add(ElimnarSeguroEvent(numberPoliza: seguro.numeroPoliza));   

                        //final data =  await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: 'cliente/Delete/${seguro.numeroPoliza}', type: HttpType.DELETE);
                      
                      
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