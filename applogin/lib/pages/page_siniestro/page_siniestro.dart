
import 'package:applogin/model/siniestro/siniestro_list.dart';
import 'package:applogin/pages/page_siniestro/list_siniestro.dart';
import 'package:applogin/pages/page_siniestro/table_siniestro.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/siniestro_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class PageSiniestro extends StatefulWidget {
  const PageSiniestro({ Key? key }) : super(key: key);

  @override
  State<PageSiniestro> createState() => _PageSiniestroState();
}

class _PageSiniestroState extends State<PageSiniestro> {

  SiniestroList listaSiniestros = SiniestroList.fromDefault();

  static bool siniestroCargado = false;
  
  @override
  void initState() {    
    super.initState();
    actualizarData();
  }

  Future<void> actualizarData() async{

    if(!siniestroCargado){
      siniestroCargado = true;    
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### data no cargada");
          
      final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/siniestros/getAll", type: HttpType.GET );
      final siniestrosList = SiniestroList.fromList(response);
      SiniestroRepository.shared.save(data: siniestrosList.siniestros, tableName: "siniestros");

    }else{
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### SINIESTROS YA REGISTRADOS");
          
    }

    final List<dynamic> siniestrosData = await SiniestroRepository.shared.selectAll(tableName: "siniestros");

    setState(()  {
          listaSiniestros = SiniestroList.fromList(siniestrosData);
    });

  }


@override
  void didUpdateWidget(covariant PageSiniestro oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("pidiendo actualizacion");
    actualizarData();
  }



  @override
  Widget build(BuildContext context) {

    return Container(
      child: Stack(
        children: [          
          EncabezadoPages(titulo: "Siniestros"),            
          Container(
            margin: EdgeInsets.only(top: 100.0),
            child:  ListView(
              children: [
                Container(
                  child: ListSiniestro(listaSiniestros: listaSiniestros)
                )
              ],
            ),
          )
        ],
      ),
    );


  }
}