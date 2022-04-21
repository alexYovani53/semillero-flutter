
import 'package:applogin/bloc/basic_bloc.dart';
import 'package:applogin/model/usuario/usuario_list.dart';
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:applogin/widgets/cupertino_bar.dart';
import 'package:applogin/widgets/gradient_back.dart';
import 'package:applogin/widgets/text_input.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:validators/validators.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({ Key? key }) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  
  final formKey = GlobalKey<FormState>();  
  
  String? validarCorreo(String value){
    if (value.isEmpty){
      return "Problema";
    }

    try {
      if (!isEmail(value)){
        return "Ingrese un correo valido";
      }
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }
  
  String? validarContrasena(String value){
    if(value.isEmpty){
      return "Ingrese una contraseña";
    }
    return null;
  }

  showAlertDialog(BuildContext context) {  
    // Create button  
    Widget okButton = ButtonGreen(  
      texto: "Ok",
      onPressed: () {  
        Navigator.of(context).pop();  
      },  
    );  
    
    // Create AlertDialog  
    AlertDialog alert = AlertDialog(  
      title: Text("!Error¡"),  
      content: Text("Datos no validos"),  
      actions: [  
        okButton,  
      ],  
    );  
    
    // show the dialog  
    showDialog(  
      context: context,  
      builder: (BuildContext context) {  
        return alert;  
      },  
    );  
  }  

  @override
  Widget build(BuildContext context) {


    final controllerCorreo = TextEditingController();
    final controllerContrasena = TextEditingController();

        return Scaffold(
          body: BlocProvider(
            create: (BuildContext context) => BasicBloc(),
            child: BlocListener<BasicBloc, BasicState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case AppStarted:
                    break;
                  case PageChanged:
                    final estado = state as PageChanged;
                    //Navigator.push(context, MaterialPageRoute(builder: (cxt) => PageError(title: estado.title)));
                    Navigator.push(context, MaterialPageRoute(builder: (cxt) => CuppertinoBar()));
                    break;
                }
              },
              child: BlocBuilder<BasicBloc, BasicState>(
                builder: (context, state) {
                  if (state is AppStarted) {
                    print('aplicacion iniciada');
                  }

                  return Stack(        
                    alignment: Alignment.center,
                    children: [
                      GradientBack(height: null,login: true),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              TextInput(inputType: TextInputType.emailAddress, hintText: "you@example.com", validator: validarCorreo,controller: controllerCorreo, icono: Icons.mail,),

                              TextInput(inputType: TextInputType.text, hintText: "Contrasena", validator: validarContrasena,controller: controllerContrasena,icono: Icons.password),
                              
                              ButtonGreen(
                                texto: "Login", 
                                onPressed: ()async{
                                    if (formKey.currentState!.validate()){
                                      
                                      

                                      String contrasena   = FirebaseRemoteConfig.instance.getString("contrasena");
                                      String correo   = FirebaseRemoteConfig.instance.getString("correo");
                                  

                                      print({"contra":contrasena,"correo: ":correo});

                                      bool login = await ejecutarLogin(controllerCorreo.text, controllerContrasena.text );
                                      print(">>>>>>>>>>>>>>>>>>>>>>Respuesta de servidor");
                                      print(login);

                                      if (!login){
                                        showAlertDialog(context); 
                                      }else{
                                        BlocProvider.of<BasicBloc>(context).add(LoginEvent(data: controllerCorreo.text));
                                      }

                                    }
                                   
                                    controllerCorreo.text = "";
                                    controllerContrasena.text ="";

                                  }, 
                              )
                            ],
                          ),
                        ),
                      
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );

  }

  Future<bool> ejecutarLogin(String correo, String password) async {

    Map<String,dynamic> parametros = <String,dynamic>{"correo":correo,"password":password} ;
    //parametros["correo"] = correo;
    //parametros["password"] = password;


    final data =  await ApiManager.shared.request(baseUrl:dotenv.env['BASE_URL']!, uri: 'usuario/login', type: HttpType.GET,uriParams:parametros);
    final lista = UsuarioList.fromList(data);

    if (lista.usuarios.isEmpty){
      return false;
    }

    return true;

  }
}