
import 'package:applogin/bloc/siniestro_bloc/siniestro_bloc.dart';
import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/model/siniestro/siniestro_list.dart';
import 'package:applogin/pages/page_siniestro/Siniestro_data.dart';
import 'package:applogin/pages/page_siniestro/list_siniestro.dart';
import 'package:applogin/pages/page_siniestro/table_siniestro.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/provider/api_siniestro_provider.dart';
import 'package:applogin/repository/siniestro_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class PageSiniestro extends StatefulWidget {
  const PageSiniestro({ Key? key }) : super(key: key);

  @override
  State<PageSiniestro> createState() => _PageSiniestroState();
}

class _PageSiniestroState extends State<PageSiniestro> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  SiniestroList listaSiniestros = SiniestroList.fromDefault();

  static bool siniestroCargado = false;
  
  @override
  void initState() {    
    super.initState();
    actualizarData();
  }

  Future<void> actualizarData() async{

    // if(!siniestroCargado){
    //   siniestroCargado = true;    
    //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### data no cargada");
          
    //   final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/siniestros/getAll", type: HttpType.GET );
    //   final siniestrosList = SiniestroList.fromList(response);
    //   print(siniestrosList);
    //   SiniestroRepository.shared.save(data: siniestrosList.siniestros, tableName: "siniestros");

    // }else{
    //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### SINIESTROS YA REGISTRADOS");
          
    // }

    // final List<dynamic> siniestrosData = await SiniestroRepository.shared.selectAll(tableName: "siniestros");

    final siniestrosData = await ApiSiniestroProvider.shared.getAll();
    setState(()  {
          listaSiniestros = siniestrosData;
    });

  }


  // @override
  // void didUpdateWidget(covariant PageSiniestro oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);

  //   print("pidiendo actualizacion");
  //   actualizarData();
  // }



  @override
  Widget build(BuildContext context) {
 return BlocProvider(
      create: (context)=>SiniestroBloc(),
      child: BlocListener<SiniestroBloc, SiniestroState>(
        listener: (context, state) {
           switch (state.runtimeType) {
            
            case InitialSiniestroState:
              break;            
              
            case VerSiniestroState:
              final data = state as VerSiniestroState;
              Navigator.push(context,MaterialPageRoute(builder: (ctx) => SiniestroData(siniestro: data.siniestro))).then((value) => {
                print(value),
                if(value != null){
                  print(value),
                  setState(() {
                    listaSiniestros.siniestros.removeWhere((element) => element.idSiniestro == value["eliminado"]);
                  })
                }
              });
              break;            

            default:
              break;
          }
          
        },
        child: BlocBuilder<SiniestroBloc, SiniestroState>(
          builder: (context, state) {
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: actualizarData,
              child: Container(
                child: Stack(
                  children: [          
                    EncabezadoPages(titulo: "Siniestros"),            
                    Container(
                      margin: EdgeInsets.only(top: 100.0),
                      child:  ListView(
                        children: [
                          Container(
                            child: ListSiniestro(
                              listaSiniestros: listaSiniestros,
                              navegar: (Siniestro siniestro){
                                BlocProvider.of<SiniestroBloc>(context).add(VerSiniestroEvent(
                                  siniestro: siniestro
                                ));
                              },
                            )
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