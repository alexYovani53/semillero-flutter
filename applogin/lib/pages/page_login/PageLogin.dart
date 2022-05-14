
import 'package:applogin/bloc/basic_bloc/basic_bloc.dart';
import 'package:applogin/localizations/localizations.dart';
import 'package:applogin/pages/page_setting/page_setting.dart';
import 'package:applogin/provider/api_local_auth.dart';
import 'package:applogin/provider/api_login.dart';
import 'package:applogin/provider/languaje_provider.dart';
import 'package:applogin/provider/themeProvider.dart';
import 'package:applogin/repository/firebase/realtime_repository.dart';
import 'package:applogin/utils/app_messages.dart';
import 'package:applogin/utils/app_preferences.dart';
import 'package:applogin/utils/app_string.dart';
import 'package:applogin/widgets/button_green.dart';
import 'package:applogin/widgets/cupertino_bar.dart';
import 'package:applogin/widgets/text_input_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import 'package:encrypt/encrypt.dart' as encriptador;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth/src/types/error_codes.dart' as auth_error;
import 'package:open_settings/open_settings.dart';

import 'package:another_flushbar/flushbar.dart';

class PageLogin extends StatefulWidget {
  
  PageLogin() : super();

  @override
  State<PageLogin> createState() => _PageLoginState();

  final keys =  encriptador.Key.fromUtf8("12345678901234567890123456789012");
  final iv = encriptador.IV.fromLength(16);
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

}

class _PageLoginState extends State<PageLogin> {
  
  final realtime = RealTimeRepository();
  
  final formKey = GlobalKey<FormState>();  
  final controllerCorreo = TextEditingController();
  final controllerContrasena = TextEditingController();    
 

  late AppLocalizations diccionary;
  
  bool isCheckedRemember = false;

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
    final ThemeProvider theme =Provider.of<ThemeProvider>(context);
    final LanguajeProvider lang = Provider.of<LanguajeProvider>(context,listen: false);
    diccionary = AppLocalizations(lang.getLanguaje);


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
                  return loginContent(blocPrincipal, theme,diccionary);
                },
              ),
            ),
          ),
          
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            tooltip: "+",
            child: Icon(Icons.settings),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (ctx) => const PageSetting()));
            },
          ),
        );

  }

  Widget loginContent(Bloc blocPrincipal,ThemeProvider theme, AppLocalizations localizations){
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end:Alignment.bottomRight,
            colors: [
              theme.getTheme == ThemeMode.light?Color(0xFF8A2387):Color.fromARGB(255, 58, 15, 56),
              theme.getTheme == ThemeMode.light?Color(0xFFE94057):Color.fromARGB(255, 128, 35, 47),
              theme.getTheme == ThemeMode.light?Color(0xFFF27121):Color.fromARGB(255, 131, 62, 19),
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
                  icon: Icon(theme.getTheme == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode),
                  onPressed: () {
                    theme.setTheme =
                        theme.getTheme == ThemeMode.light
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
                color: theme.getTheme == ThemeMode.light? Colors.white : Color.fromARGB(255, 113, 125, 131),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.dictionary(Strings.loginTextLabel1),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextInputCustom(inputType: TextInputType.emailAddress, hintText: "you@example.com", validator: validarCorreo,controller: controllerCorreo, icono: Icons.mail,),

                    TextInputCustom(inputType: TextInputType.text, hintText: localizations.dictionary(Strings.loginPassword), validator: validarContrasena,controller: controllerContrasena,icono: Icons.password),
                    


                    ButtonGreen(
                      texto: localizations.dictionary(Strings.loginTextButton), 
                      onPressed: ()async{

                          await loadContrasena();
                          if (formKey.currentState!.validate()){
                            await ejecutarLogin(controllerCorreo.text, controllerContrasena.text ,blocPrincipal);
                          }else{
                            await Future.delayed(const Duration(seconds: 2), () {
                              formKey.currentState!.reset();
                            }); 
                          }
                          
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
                                value: isCheckedRemember,
                                onChanged: _handleRemeberme,
                              ),
                            )
                          ),
                          SizedBox(width: 10.0),
                          Text(localizations.dictionary(Strings.loginRemember),
                            style: TextStyle(
                            color:theme.getTheme == ThemeMode.light? Color(0xff646464): Color.fromARGB(255, 224, 223, 223),
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



  void _loadUserEmailPassword() async {

    try {

      AppPreferences.shared.contains(AppPreferences.APP_REMEMBER).then((bool value) async {
        if (value){
          String email = await AppPreferences.shared.getString(AppPreferences.APP_EMAIL) ?? "";
          bool remember = await AppPreferences.shared.getBool(AppPreferences.APP_REMEMBER) ?? false;

          if (remember) {
            setState(() {
              isCheckedRemember = true;
            });
            controllerCorreo.text = email ;
            // bool pasoPrueba = await ApiLocalAuth.shared.authenticateBiometrics();

            // if(pasoPrueba){
            //   final decryptedPass = decrypt(password);
            //   controllerContrasena.text = decryptedPass;
            // }
          }
        }
      });

    } catch (e) {
      print(e);
    }
  }

  Future<void> loadContrasena() async{
  
    try{

      if (isCheckedRemember && controllerContrasena.text == ""){
          String password = await AppPreferences.shared.getString(AppPreferences.APP_PASSWORD) ?? "";
          bool remember = await AppPreferences.shared.getBool(AppPreferences.APP_REMEMBER) ?? false;

        if (remember) {
          setState(() {
            isCheckedRemember = true;
          });
          
          authenticateBiometrics().then((statusOk){
            if(statusOk){
              final decryptedPass = widget.decrypt(password);
              controllerContrasena.text = decryptedPass;
            }
          });

        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _handleRemeberme(bool? value) async {

    await hasBiometrics().then((hasBiometrics) => {
      if(hasBiometrics == true){
        isCheckedRemember = value!,
        setState(() {
          isCheckedRemember = value;
        })
      }
      else{
        setState(() {
          isCheckedRemember = false;
        }),
        AppMessages.shared.showAlertDialog(context,"!Biometria!","No se cuenta con sensor de huella para usar esta funcionalidad",(){})
      }
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

    final passwordEncrypted = widget.encrypt(controllerContrasena.text);
    showFlushBar(passwordEncrypted,"Contraseña Encriptada");

    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", checked);
        prefs.setString('email', controllerCorreo.text);
        prefs.setString('password', passwordEncrypted);
      },
    );
  }





  Future<void> ejecutarLogin(String correoLog, String password, Bloc blocPrincipal) async {

    // String contrasena   = FirebaseRemoteConfig.instance.getString("contrasena");
    // String correo   = FirebaseRemoteConfig.instance.getString("correo");

    bool login = await ApiLogin.shared.ejecutarLogin(correoLog, password);
    if (!login){
      AppMessages.shared.showAlertDialog(context,"!Error¡","Datos incorrectos",(){}); 
      if(isCheckedRemember) {
        setState(() { isCheckedRemember = false;});
      }
    }else{
      await saveSharedPreference(isCheckedRemember);
      blocPrincipal.add(LoginEvent(data:controllerCorreo.text));
    }
  }

  Future<bool> hasBiometrics() async {

    try {
      return await ApiLocalAuth.shared.getAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async{
    try {
      return await ApiLocalAuth.shared.getAuth.getAvailableBiometrics();
    } on PlatformException  catch (e) {
      return <BiometricType>[];
    }
  }

  Future<bool> authenticateBiometrics() async{ 

    //final isAvailable = await hasBiometrics();    
    //if(!isAvailable) return true;
    
    final Title = diccionary.dictionary(Strings.biometricsTituloDialog);

    try {
      return await ApiLocalAuth.shared.getAuth.authenticate(
        localizedReason: diccionary.dictionary(Strings.biometricsLocalizedReason),
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: diccionary.dictionary(Strings.biometricsSingInTitle),
            cancelButton: diccionary.dictionary(Strings.biometricsCancelButton), 
            biometricHint:  diccionary.dictionary(Strings.biometricsBiometricHint),
          ),
        ]
      );
    } on PlatformException  catch (e) {
      if(e.code == auth_error.notEnrolled){
        showFlushBar(Title, diccionary.dictionary(Strings.biometricsNoConfigurado));
        // AppMessages.shared.showAlertDialog(context, "Biometria", "Desea configurar su huella", () { 
        //    OpenSettings.openSecuritySetting();
        // });
      }
      else if( e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut){
        showFlushBar(Title, diccionary.dictionary(Strings.biometricsBloqueado));
      }
      else if(e.code == auth_error.notAvailable){
        showFlushBar(Title, diccionary.dictionary(Strings.biometricsNoDisponible));
      }
      return false;
    }

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