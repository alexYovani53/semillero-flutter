import 'package:applogin/bloc/cliente_bloc/cliente_bloc.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/provider/api_cliente_provider.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:applogin/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddClient extends StatefulWidget {

  Cliente?clientEdit;

  AddClient({ 
    Key? key,
    this.clientEdit 
  }) : super(key: key);

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {

  
  Map<String, dynamic> body = <String,dynamic>{};
  bool formularioActivo = false;
  final formKey = GlobalKey<FormState>();  

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

  Widget formulario(BuildContext context){

      if(widget.clientEdit!= null){
            body["dniCl"] = widget.clientEdit!.dniCl;
            controllerCiudad.text = widget.clientEdit!.ciudad;
            controllerObservaciones.text =widget.clientEdit!.observaciones;
            controllerCodPostal.text = widget.clientEdit!.codPostal.toString();
            controllerTelefono.text = widget.clientEdit!.telefono.toString();
            controllerApp1.text = widget.clientEdit!.apellido1;
            controllerApp2.text = widget.clientEdit!.apellido2;
            controllerClaseVia.text =widget.clientEdit!.claseVia;
            controllerNombre.text =widget.clientEdit!.nombreCl;
            controllerNombreVia.text =widget.clientEdit!.nombreVia;
            controllerNumeroVia.text =widget.clientEdit!.numeroVia.toString()  ;

      }

      return Column(
        children: [
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
                 
                Container(
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: 
                    ButtonGreen(
                      texto: "Registrar", 
                      onPressed: ()async{
                          if (formKey.currentState!.validate()){
                            
                              body["dniCl"]= 0;
                              body["ciudad"]=controllerCiudad.text;
                              body["observaciones"]=controllerObservaciones.text;
                              body["codPostal"]=int.parse(controllerCodPostal.text);
                              body["telefono"]=int.parse(controllerTelefono.text);
                              body["apellido1"]=controllerApp1.text;
                              body["apellido2"]=controllerApp2.text;
                              body["claseVia"]=controllerClaseVia.text;
                              body["nombreCl"]=controllerNombre.text;
                              body["nombreVia"]=controllerNombreVia.text;
                              body["numeroVia"]=int.parse(controllerNumeroVia.text);
                            

                            final response = await ApiClienteProvider.shared.guardarCliente(body);
                            // //final response = await ApiManager.shared.request(baseUrl: dotenv.env['BASE_URL']!, uri: "/cliente/Post", type: HttpType.POST,bodyParams: body);
                            // final ClienteNuevo = Cliente.fromServiceSpring(body);
                            // final response = await ClienteRepository.shared.save(data: [ClienteNuevo], tableName:"cliente");

                            body = <String,dynamic>{};
                            if (response !=null){                       
                                
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

                              BlocProvider.of<ClienteBloc>(context).add(SalirRegistroClienteEvent());
                              
                            }
                          }
                          
                        }, 
                    )
                )
              ],
            ),
          ) 
    
        ],
      );

  }


  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
      create: (context) => ClienteBloc(),
      child: BlocListener<ClienteBloc, ClienteState>(
        listener: (context,  state) {
          switch (state.runtimeType) {
            case RegresarAPageState:              
                Navigator.pop(context);
              break;
            default:
              break;
          }
        },
        child: BlocBuilder<ClienteBloc, ClienteState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: ListView(
                children: [
                  formulario(context)
                ],
              ),
            );
          },
        )
      ),
    );
  }
}
