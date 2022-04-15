
import 'package:applogin/model/siniestro/siniestro_list.dart';
import 'package:applogin/pages/page_siniestro/table_siniestro.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:flutter/material.dart';


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

    final response = await ApiManager.shared.request(baseUrl: "3.19.244.228:8585", uri: "/siniestros/getAll", type: HttpType.GET );
    
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
    return  Container(
      child: Column(
        children: [
          EncabezadoPages(titulo: "Siniestros"),
            Container(
                child: TableSiniestro(listaSiniestro: listaSiniestros,actualizar: (){
                  actualizarData();
                }),
              )
        ],
      ),
    );
  }
}