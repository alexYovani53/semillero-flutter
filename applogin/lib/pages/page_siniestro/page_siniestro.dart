
import 'package:applogin/model/siniestro/siniestro_list.dart';
import 'package:applogin/pages/page_siniestro/table_siniestro.dart';
import 'package:applogin/provider/api_manager.dart';
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

  
  @override
  void initState() {    
    super.initState();
    actualizarData();
  }

  Future<void> actualizarData() async{

    final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/siniestros/getAll", type: HttpType.GET );
    
    print("REspuesta");
    print(response);

    setState(()  {
          listaSiniestros = SiniestroList.fromList(response);
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
                    height: 500.0,
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight:Radius.circular(20.0)
                      )
                    ),
                  child: TableSiniestro(listaSiniestro: listaSiniestros,actualizar: (){
                    actualizarData();
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );


  }
}