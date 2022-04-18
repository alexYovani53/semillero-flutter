
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/pages/page_seguro/table_seguro.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:applogin/pages/page_client/TableClient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class PageSeguro extends StatefulWidget {
  const PageSeguro({ Key? key }) : super(key: key);

  @override
  State<PageSeguro> createState() => _PageSeguroState();
}

class _PageSeguroState extends State<PageSeguro> {

  SeguroList seguroList = SeguroList.fromDefault();

  void actualizarData () async{

    final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/seguros/GetAll", type: HttpType.GET );
    setState(()  {
          seguroList = SeguroList.fromList(response);
    });
  }

  @override
  void didUpdateWidget(covariant PageSeguro oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("pidiendo actualizacion");
    actualizarData();
  }

  
  @override
  void initState(){
    super.initState();
    actualizarData();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Stack(
        children: [          
          EncabezadoPages(titulo: "Seguros"),            
          Container(
            margin: EdgeInsets.only(top: 100.0),
            child:  ListView(
              children: [
                Container(
                  height: 650.0,
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
                  child: TableSeguro(listaSeguros: seguroList,actualizar: (){
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