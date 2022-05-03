
import 'package:applogin/bloc/basic_bloc/basic_bloc.dart';
import 'package:applogin/main.dart';
import 'package:applogin/provider/api_local_auth.dart';
import 'package:applogin/provider/api_login.dart';
import 'package:applogin/repository/firebase/realtime_repository.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:applogin/widgets/cupertino_bar.dart';
import 'package:applogin/widgets/text_input.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import 'package:encrypt/encrypt.dart' as encriptador;
import 'package:local_auth/local_auth.dart';

import 'package:another_flushbar/flushbar.dart';

class PageLogin extends StatefulWidget {
  const PageLogin() : super();

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  
  final realtime = RealTimeRepository();
  
  final formKey = GlobalKey<FormState>();  
  final controllerCorreo = TextEditingController();
  final controllerContrasena = TextEditingController();    
  final keys =  encriptador.Key.fromUtf8("12345678901234567890123456789012");
  final iv = encriptador.IV.fromLength(16);
  
  bool _isChecked = false;

  // BIOMETRIA
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState(){
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final BasicBloc blocPrincipal = BlocProvider.of<BasicBloc>(context);

        return Scaffold(
          body: BlocProvider(
            create: (BuildContext context) => BasicBloc(),
            child: BlocListener<BasicBloc, BasicState>(
              listener: (context, state) {
                switch (state.runtimeType) {
                  case AppStarted:
                    break;
                  case LogExitosoState:
                    final estado = state as LogExitosoState;
                    //Navigator.push(context, MaterialPageRoute(builder: (cxt) => PageError(title: estado.title)));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (cxt) => CuppertinoBar()));
                    break;
                }
              },
              child: BlocBuilder<BasicBloc, BasicState>(
                builder: (context, state) {
                  if (state is AppStarted) print('aplicacion iniciada');
                  return loginContent(blocPrincipal);
                },
              ),
            ),
          ),
        );

  }

  Widget loginContent(Bloc blocPrincipal){
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:Alignment.bottomRight,
            colors: [
              MyApp.themeNotifier.value == ThemeMode.light?Color(0xFF8A2387):Color.fromARGB(255, 58, 15, 56),
              MyApp.themeNotifier.value == ThemeMode.light?Color(0xFFE94057):Color.fromARGB(255, 128, 35, 47),
              MyApp.themeNotifier.value == ThemeMode.light?Color(0xFFF27121):Color.fromARGB(255, 131, 62, 19),
            ]
          )
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [                  
                IconButton(
                  icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode),
                  onPressed: () {
                    realtime.updateThemeMode();
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                  }
                ),
              ],
            ),
            SizedBox(height: 120,),
            Container(
              height: 480,
              width: 325,
              decoration: BoxDecoration(
                color: MyApp.themeNotifier.value == ThemeMode.light? Colors.white : Color.fromARGB(255, 113, 125, 131),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bienvenido",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextInput(inputType: TextInputType.emailAddress, hintText: "you@example.com", validator: validarCorreo,controller: controllerCorreo, icono: Icons.mail,),

                    TextInput(inputType: TextInputType.text, hintText: "Contrasena", validator: validarContrasena,controller: controllerContrasena,icono: Icons.password),
                    


                    ButtonGreen(
                      texto: "Login", 
                      onPressed: ()async{
                          if (formKey.currentState!.validate()){

                            await ejecutarLogin(controllerCorreo.text, controllerContrasena.text ,blocPrincipal);
                            
                          }else{
                            await Future.delayed(const Duration(seconds: 2), () {
                              formKey.currentState!.reset();
                            }); 
                          }
                          
                          controllerCorreo.text = "";
                          controllerContrasena.text ="";
                        }, 
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,                          
                            child: Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xff00C8E8) // Your color
                              ),
                              child: Checkbox(
                                activeColor: Color(0xff00C8E8),
                                value: _isChecked,
                                onChanged: _handleRemeberme,
                              ),
                            )
                          ),
                          SizedBox(width: 10.0),
                          Text("Remember Me",
                            style: TextStyle(
                            color:MyApp.themeNotifier.value == ThemeMode.light? Color(0xff646464): Color.fromARGB(255, 224, 223, 223),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Rubic')
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),      
            ),
          ],
        ),
      ),
    );
  }

  String? validarCorreo(String value){
    if (value.isEmpty) return "Problema";
    try {
      if (!isEmail(value)) return "Ingrese un correo valido";      
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }
  
  String? validarContrasena(String value){
    if(value.isEmpty) return "Ingrese una contraseña";
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


  void _loadUserEmailPassword() async {

    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      if (_prefs.containsKey("remember_me")){
        var email = _prefs.getString("email") ?? "";
        var password = _prefs.getString("password") ?? "";
        var remeberMe = _prefs.getBool("remember_me") ?? false;

        if (remeberMe) {
          setState(() {
            _isChecked = true;
          });
          controllerCorreo.text = email ;
          bool pasoPrueba = await ApiLocalAuth.shared.authenticateBiometrics();

          if(pasoPrueba){
            final decryptedPass = decrypt(password);
            controllerContrasena.text = decryptedPass;
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _handleRemeberme(bool? value) {
    _isChecked = value!;
    //saveSharedPreference(value);
    setState(() {
      _isChecked = value;
    });
  }
  
  Future<void> saveSharedPreference(bool checked) async {
    
    if(!checked) {
      await SharedPreferences.getInstance().then(
        (prefs) async {
          if(prefs.containsKey("remember_me")) await prefs.remove("remember_me");
          if(prefs.containsKey("email")) await prefs.remove("email");
          if(prefs.containsKey("password")) await prefs.remove("password");
        },
      );
      return;
    }

    final passwordEncrypted = encrypt(controllerContrasena.text);
    showFlushBar(passwordEncrypted,"Contraseña Encriptada");

    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", checked);
        prefs.setString('email', controllerCorreo.text);
        prefs.setString('password', passwordEncrypted);
      },
    );
  }


  String encrypt(String text ){    
    final encrypter = encriptador.Encrypter(encriptador.AES(keys));
    final encryptedData = encrypter.encrypt(text,iv: iv);
    return encryptedData.base64;
  }

  String decrypt(String text ){    
    final encrypter = encriptador.Encrypter(encriptador.AES(keys));
    final decryptedData = encrypter.decrypt(encriptador.Encrypted.fromBase64(text),iv: iv);
    return decryptedData;
  }


  Future<void> ejecutarLogin(String correoLog, String password, Bloc blocPrincipal) async {

    String contrasena   = FirebaseRemoteConfig.instance.getString("contrasena");
    String correo   = FirebaseRemoteConfig.instance.getString("correo");

    bool login = await ApiLogin.shared.ejecutarLogin(correoLog, password);
    if (!login){
      showAlertDialog(context); 
      if(_isChecked) {
        setState(() { _isChecked = false;});
      }
    }else{
      await saveSharedPreference(_isChecked);
      blocPrincipal.add(LoginEvent(data:controllerCorreo.text));
    }
  }

  void showFlushBar(String texto, String titulo){
    Flushbar(
      title:  titulo,
      message:  texto,
      duration:  const Duration(seconds: 3),            
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