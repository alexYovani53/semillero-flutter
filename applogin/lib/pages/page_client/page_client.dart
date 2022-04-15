
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:applogin/pages/page_client/TableClient.dart';
import 'package:applogin/widgets/text_input.dart';
import 'package:flutter/material.dart';


class PageClient extends StatefulWidget {
  const PageClient({ Key? key }) : super(key: key);

  @override
  State<PageClient> createState() => _PageClientState();
}

class _PageClientState extends State<PageClient> {

  ClienteList clientList = ClienteList.fromDefault();
  Map<String, dynamic> body = <String,dynamic>{};
  bool formularioActivo = false;
  final formKey = GlobalKey<FormState>();  

  void actualizarData () async{

    final response = await ApiManager.shared.request(baseUrl: "3.19.244.228:8585", uri: "/cliente/GetAll", type: HttpType.GET );
    setState(()  {
          clientList = ClienteList.fromList(response);
    });
  }
  
  @override
  void didUpdateWidget(covariant PageClient oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print("pidiendo actualizacion");
    actualizarData();
  }

  
  final controllerNombre = TextEditingController();
  final controllerApp1 = TextEditingController();
  final controllerApp2 = TextEditingController();
  final controllerClaseVia = TextEditingController();
  final controllerNumeroVia = TextEditingController();
  final controllerNombreVia = TextEditingController();
  final controllerCodPostal = TextEditingController();
  final controllerCiudad = TextEditingController();
  final controllerTelefono = TextEditingController();  
  final controllerObservaciones = TextEditingController();

  Widget formulario(){
    if (formularioActivo){
      return Column(
        children: [
          IconButton(onPressed: (){
            setState(() {
              formularioActivo = false;
            });
          }, icon: Icon(Icons.close)),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextInput(inputType: TextInputType.text, hintText: "Nombre",controller: controllerNombre, icono: Icons.mail , validator: (String data){
                    if(data.isEmpty){
                      return "Ingrese un nombre";
                    } return null;
                }),

                TextInput(inputType: TextInputType.text, hintText: "Apellido 1",controller: controllerApp1,icono: Icons.password, validator: (String data){ 
                    if(data.isEmpty){
                      return "Ingrese primer apellido";
                    } return null;
                  }),
                TextInput(inputType: TextInputType.text, hintText: "Apellido 2",controller: controllerApp2,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return "Ingrese segundo apellido";
                    } return null;
                  }),
                TextInput(inputType: TextInputType.text, hintText: "Clase Via",controller: controllerClaseVia,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return "Llenar clase via";
                    } return null;
                  }),
                TextInput(inputType: TextInputType.number, hintText: "Numero Via",controller: controllerNumeroVia,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return "Ingrese numero via";
                    } return null;
                  }),
                TextInput(inputType: TextInputType.text, hintText: "Nombre Via", controller: controllerNombreVia,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return "Ingrese nombre via";
                    } return null;
                  }),
                TextInput(inputType: TextInputType.number, hintText: "Cod. Postal", controller: controllerCodPostal,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return "Ingrese su codigo postal";
                    } return null;
                  }),
                TextInput(inputType: TextInputType.text, hintText: "Ciudad", controller: controllerCiudad,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return "Ingrese su ciudad";
                    } return null;
                  }),
                TextInput(inputType: TextInputType.number, hintText: "Telefono",controller: controllerTelefono,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return "Ingrese un número telefonico";
                    } return null;
                  }),
                TextInput(inputType: TextInputType.text, hintText: "Observaciones",controller: controllerObservaciones,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return "Ingrese alguna opservacion";
                    } return null;
                  }),
                 
                
                ButtonGreen(
                  texto: "Registrar", 
                  onPressed: ()async{
                      if (formKey.currentState!.validate()){
                        

                          body["ciudad"]=controllerCiudad.text;
                          body["observaciones"]=controllerObservaciones.text;
                          body["codPostal"]=controllerCodPostal.text;
                          body["telefono"]=controllerTelefono.text;
                          body["apellido1"]=controllerApp1.text;
                          body["apellido2"]=controllerApp2.text;
                          body["claseVia"]=controllerClaseVia.text;
                          body["nombreCl"]=controllerNombre.text;
                          body["nombreVia"]=controllerNombreVia.text;
                          body["numeroVia"]=controllerNumeroVia.text;
                        

                        final response = await ApiManager.shared.request(baseUrl: "3.19.244.228:8585", uri: "/cliente/Post", type: HttpType.POST,bodyParams: body);
                        
                        body = <String,dynamic>{};
                        if (response !=null){
                          actualizarData();
                        }
                        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Respuesta");
                        print(response);

                        setState(() {
                          formularioActivo = false;
                        });
                        
                      }
                      
                      controllerCiudad.text = "";
                      controllerObservaciones.text ="";
                      controllerCodPostal.text = "";
                      controllerTelefono.text ="";
                      controllerApp1.text = "";
                      controllerApp2.text = "";
                      controllerClaseVia.text ="";
                      controllerNombre.text ="";
                      controllerNombreVia.text ="";
                      controllerNumeroVia.text ="";
                        
                    }, 
                )
              ],
            ),
          ) 
    
        ],
      );
    }else{
      return IconButton(onPressed: (){
        setState(() {
          formularioActivo = true;
        });
      }, icon: Icon(Icons.add));
    }
  }

  void editar(Cliente edit){
                      
    body["dniCl"] = edit.dniCl;
    controllerCiudad.text = edit.ciudad;
    controllerObservaciones.text =edit.observaciones;
    controllerCodPostal.text = edit.codPostal.toString();
    controllerTelefono.text = edit.telefono.toString();
    controllerApp1.text = edit.apellido1;
    controllerApp2.text = edit.apellido2;
    controllerClaseVia.text =edit.claseVia;
    controllerNombre.text =edit.nombreCl;
    controllerNombreVia.text =edit.nombreVia;
    controllerNumeroVia.text =edit.numeroVia.toString()  ;

    setState(() {
      formularioActivo = true;
    });
                            
  }

  @override
  void initState() {
    super.initState();
    actualizarData();
    formularioActivo = false;
    formulario();
  }


  @override
  Widget build(BuildContext context) {  
    


    
    return  Container(
      child: ListView(

        children: [
          
          EncabezadoPages(titulo: "Clientes"),            
          formulario(),
          Container(
              child: TableClient(listaCliente: clientList,actualizar: () {
                actualizarData();
              },editar: editar),
          )  
        ],
      ),
    );
  }
}