
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/model/seguro/seguro_list.dart';
import 'package:applogin/pages/page_seguro/table_seguro.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:applogin/pages/page_client/TableClient.dart';
import 'package:flutter/material.dart';


class PageSeguro extends StatefulWidget {
  const PageSeguro({ Key? key }) : super(key: key);

  @override
  State<PageSeguro> createState() => _PageSeguroState();
}

class _PageSeguroState extends State<PageSeguro> {

  SeguroList seguroList = SeguroList.fromDefault();

  void actualizarData () async{

    final response = await ApiManager.shared.request(baseUrl: "3.19.244.228:8585", uri: "/seguros/GetAll", type: HttpType.GET );
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
    return  Container(
      child: Column(
        children: [
          EncabezadoPages(titulo: "Seguros"),
          Container(
            child: TableSeguro(listaSeguros: seguroList,actualizar: (){
              actualizarData();
            }),
          )
                          
        ],
      ),
    );
  }
}