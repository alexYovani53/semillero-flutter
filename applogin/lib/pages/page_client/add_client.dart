import 'package:another_flushbar/flushbar.dart';
import 'package:applogin/bloc/cliente_bloc/cliente_bloc.dart';
import 'package:applogin/localizations/localizations.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/provider/api_cliente_provider.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/provider/languaje_provider.dart';
import 'package:applogin/repository/cliente_repository.dart';
import 'package:applogin/utils/app_string.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:applogin/widgets/text_input_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

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
  late AppLocalizations dictionary;

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

                TextInputCustom(inputType: TextInputType.text, hintText: dictionary.dictionary(Strings.formClienteNombre),controller: controllerNombre, icono: Icons.mail , validator: (String data){
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorNombre);
                    } return null;
                }),

                TextInputCustom(inputType: TextInputType.text, hintText: dictionary.dictionary(Strings.formClienteApellido1),controller: controllerApp1,icono: Icons.password, validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorApellido1);
                    } return null;
                  }),
                TextInputCustom(inputType: TextInputType.text, hintText: dictionary.dictionary(Strings.formClienteApellido2),controller: controllerApp2,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorApellido2);
                    } return null;
                  }),
                TextInputCustom(inputType: TextInputType.text, hintText: dictionary.dictionary(Strings.formClienteClaseVia),controller: controllerClaseVia,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorClaseVia);
                    } return null;
                  }),
                TextInputCustom(inputType: TextInputType.number, hintText: dictionary.dictionary(Strings.formClienteNumeroVia),controller: controllerNumeroVia,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorNumeroVia);
                    } return null;
                  }),
                TextInputCustom(inputType: TextInputType.text, hintText: dictionary.dictionary(Strings.formClienteNombreVia), controller: controllerNombreVia,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorNombreVia);
                    } return null;
                  }),
                TextInputCustom(inputType: TextInputType.number, hintText: dictionary.dictionary(Strings.formClienteCodPostal), controller: controllerCodPostal,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorCodPostal);
                    } return null;
                  }),
                TextInputCustom(inputType: TextInputType.text, hintText: dictionary.dictionary(Strings.formClienteCiudad), controller: controllerCiudad,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorCiudad);
                    } return null;
                  }),
                TextInputCustom(inputType: TextInputType.number, hintText: dictionary.dictionary(Strings.formClienteTelefono),controller: controllerTelefono,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorNumeroVia);
                    } return null;
                  }),
                TextInputCustom(inputType: TextInputType.text, hintText: dictionary.dictionary(Strings.formClienteObservaciones),controller: controllerObservaciones,icono: Icons.password,validator: (String data){ 
                    if(data.isEmpty){
                      return dictionary.dictionary(Strings.formClienteValidatorObservaciones);
                    } return null;
                  }),
                 
                Container(
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: 
                    ButtonGreen(
                      texto: dictionary.dictionary(Strings.buttonRegistrar), 
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
                              showFlushBar(dictionary.dictionary(Strings.pageClienteTitle), dictionary.dictionary(Strings.formClienteMessageRegister));
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

    final lang = Provider.of<LanguajeProvider>(context);
    dictionary = AppLocalizations(lang.getLanguaje);  

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
  showFlushBar(String titulo, String texto){
    Flushbar(
      title:  titulo,
      message:  texto,
      duration:  const Duration(seconds: 6),            
      margin:    const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      flushbarPosition: FlushbarPosition.TOP,
      leftBarIndicatorColor: Colors.blue[300],
    ).show(context);
  }
}
