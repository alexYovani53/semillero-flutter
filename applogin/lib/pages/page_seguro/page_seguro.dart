
import 'package:applogin/bloc/seguro_bloc/seguro_bloc.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/pages/page_seguro/Seguro_data.dart';
import 'package:applogin/pages/page_seguro/list_client.dart';
import 'package:applogin/pages/page_seguro/table_seguro.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/provider/api_seguro_provider.dart';
import 'package:applogin/repository/seguro_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:applogin/pages/page_client/TableClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class PageSeguro extends StatefulWidget {
  const PageSeguro({ Key? key }) : super(key: key);

  @override
  State<PageSeguro> createState() => _PageSeguroState();
}

class _PageSeguroState extends State<PageSeguro> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  SeguroList seguroList = SeguroList.fromDefault();
  static bool seguroCargado = false;

  Future<void> actualizarData () async{

    // if (!seguroCargado){
    //   seguroCargado = true;
    //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### data no cargada");
    //   final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/seguros/GetAll", type: HttpType.GET );
    //   final segurosList = SeguroList.fromList(response);
    //   SeguroRepository.shared.save(data: segurosList.seguros, tableName: "seguros");

    // }else{
    //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### SEGUROS YA REGISTRADOS");
      
    // }
    
    // final List<dynamic> segurosData = await SeguroRepository.shared.selectAll(tableName: "seguros");

    final segurosData = await ApiSeguroProvider.shared.getAll();

    setState(() {
      seguroList = segurosData;
    });
  }

  // @override
  // void didUpdateWidget(covariant PageSeguro oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);

  //   print("pidiendo actualizacion");
  //   actualizarData();
  // }

  
  @override
  void initState(){
    super.initState();
    actualizarData();
  }

  @override
  Widget build(BuildContext context) {

  
    return BlocProvider(
      create: (context)=>SeguroBloc(),
      child: BlocListener<SeguroBloc, SeguroState>(
        listener: (context, state) {
           switch (state.runtimeType) {
            
            case InitialSeguroState:
              break;            
              
            case VerSeguroState:
              final data = state as VerSeguroState;
              Navigator.push(context,MaterialPageRoute(builder: (ctx){
                return SeguroData(seguro: data.seguro);
              })).
              
              then((value) => {
                if(value != null){
                  setState(() {
                    seguroList.seguros.removeWhere((element) => element.numeroPoliza == value["eliminado"]);
                  })
                }
              });
              // Navigator.push(context,MaterialPageRoute(builder: (ctx) => SeguroData(seguro: data.seguro))).then((value) => {
              //   print(value),
              //   if(value != null){
              //     print(value),
              //     setState(() {
              //       seguroList.seguros.removeWhere((element) => element.numeroPoliza == value["eliminado"]);
              //     })
              //   }
              // });
              break;            

            default:
              break;
          }
          
        },
        child: BlocBuilder<SeguroBloc, SeguroState>(
          builder: (context, state) {
            return RefreshIndicator(
              key:_refreshIndicatorKey,
              onRefresh: actualizarData,
              child: Scaffold(
                body: Stack(
                  children: [          
                    EncabezadoPages(titulo: "Seguros"),            
                    Container(
                      margin: EdgeInsets.only(top: 100.0),
                      child:  ListView(
                        children: [
                          Container(
                            child: ListSeguro(
                              listaSeguros: seguroList,
                              navegar: (Seguro seguro){
                                BlocProvider.of<SeguroBloc>(context).add(VerSeguroEvent(seguro: seguro));
                              })
                          ) 
                        ],
                      ),
                    )
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