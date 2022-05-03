
import 'package:applogin/bloc/cliente_bloc/cliente_bloc.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/pages/page_client/add_client.dart';
import 'package:applogin/pages/page_client/client_data.dart';
import 'package:applogin/pages/page_client/list_client.dart';
import 'package:applogin/provider/api_cliente_provider.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class PageClient extends StatefulWidget {
  const PageClient({ Key? key }) : super(key: key);

  @override
  State<PageClient> createState() => _PageClientState();
}

class _PageClientState extends State<PageClient> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

  static bool clienteCargado = false;
  
  ClienteList clientList = ClienteList.fromDefault();
  Map<String, dynamic> body = <String,dynamic>{};
  bool formularioActivo = false;
  final formKey = GlobalKey<FormState>();  

  Future<void> actualizarData () async{

        // if (!clienteCargado){
        //   clienteCargado = true;
        //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### data no cargada");
        //   final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/cliente/GetAll", type: HttpType.GET );
        //   clientList = ClienteList.fromList(response);
        //   ClienteRepository.shared.save(data: clientList.clientes, tableName: "cliente");
        // }else{
        //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>****************###################### CLIENTES YA REGISTRADOS");
        // }

        // final List<dynamic> clientesData = await ClienteRepository.shared.selectAll(tableName: "cliente");
        
        print("llego aca");
        final data = await ApiClienteProvider.shared.getAll();
        
        setState(() {
          clientList = data;
        });

  }
  
  // @override
  // void didUpdateWidget(covariant PageClient oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   actualizarData();
  // }

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
      
    return BlocProvider(

      create: (BuildContext contextbloc)=> ClienteBloc(),
      child: BlocListener<ClienteBloc, ClienteState>(
        listener: (context,  state) {
          switch (state.runtimeType) {
            
            case InitialClientState:
              break;            
              
            case VerClienteState:
              final data = state as VerClienteState;
              Navigator.push(context,MaterialPageRoute(builder: (ctx) => ClientData(cliente: data.client))).then((value) => {
                if(value != null){
                  setState(() {
                    clientList.clientes.removeWhere((element) => element.dniCl == value["eliminado"]);
                  })
                }
              });
              break;            

            case AgregarClientState:
                Navigator.push(context,MaterialPageRoute(builder: (ctx) => AddClient()));
              break;
            default:
              break;
          }
        },
        child: BlocBuilder<ClienteBloc, ClienteState>(
          builder: (context, state) {
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: actualizarData,
              child: Scaffold(
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
                                  BlocProvider.of<ClienteBloc>(context).add(AgregarClienteEvent());
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
                              child: ListClient(
                                listaCliente: clientList,
                                navegar: (Cliente client){
                                  BlocProvider.of<ClienteBloc>(context).add(VerClienteEvent(client: client));
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

        )
      )
        
    );
  }
}