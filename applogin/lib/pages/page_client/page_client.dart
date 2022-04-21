
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/pages/page_client/add_client.dart';
import 'package:applogin/pages/page_client/list_client.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:applogin/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class PageClient extends StatefulWidget {
  const PageClient({ Key? key }) : super(key: key);

  @override
  State<PageClient> createState() => _PageClientState();
}

class _PageClientState extends State<PageClient> {



  static bool clienteCargado = false;
  
  ClienteList clientList = ClienteList.fromDefault();
  Map<String, dynamic> body = <String,dynamic>{};
  bool formularioActivo = false;
  final formKey = GlobalKey<FormState>();  

  Future<void> actualizarData () async{

        if (!clienteCargado){
          clienteCargado = true;
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### data no cargada");
          final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/cliente/GetAll", type: HttpType.GET );
          clientList = ClienteList.fromList(response);
          ClienteRepository.shared.save(data: clientList.clientes, tableName: "cliente");
        }else{
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### CLIENTES YA REGISTRADOS");
        }

        final List<dynamic> clientesData = await ClienteRepository.shared.selectAll(tableName: "cliente");
        setState(() {
          clientList = ClienteList.fromDb(clientesData);
        });

  }
  
  @override
  void didUpdateWidget(covariant PageClient oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("pidiendo actualizacion");
    actualizarData();
  }

  // void editar(Cliente edit){
                      
  //   body["dniCl"] = edit.dniCl;
  //   controllerCiudad.text = edit.ciudad;
  //   controllerObservaciones.text =edit.observaciones;
  //   controllerCodPostal.text = edit.codPostal.toString();
  //   controllerTelefono.text = edit.telefono.toString();
  //   controllerApp1.text = edit.apellido1;
  //   controllerApp2.text = edit.apellido2;
  //   controllerClaseVia.text =edit.claseVia;
  //   controllerNombre.text =edit.nombreCl;
  //   controllerNombreVia.text =edit.nombreVia;
  //   controllerNumeroVia.text =edit.numeroVia.toString()  ;

  //   setState(() {
  //     formularioActivo = true;
  //   });
                            
  // }

  @override
  void initState() {
    super.initState();
    actualizarData();
  }


  @override
  Widget build(BuildContext context) {  
      
    return  Scaffold(
      body: Stack(
        children: [          
          EncabezadoPages(titulo: "Clientes"),            
          Container(
            margin: EdgeInsets.only(top: 100.0),
            child:  ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddClient(),
                        ));
                      }, 
                      icon: const Icon(Icons.add)
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await ClienteRepository.shared.addColumn(tableName: "cliente", columnName: "clienteNewColumn");
                        
                        await ClienteRepository.shared.update(tableName: "cliente", columnName: "clienteNewColumn",value: "Data - generada");
                        
                        await actualizarData();
                      }, 
                      icon: Icon(Icons.add), 
                      label: Text("Add column")
                    )
                  ],
                ),
                Container(
                    child: ListClient(listaCliente: clientList)
                )  
              ],
            ),
          )
        ],
      ),
    );
  }
}