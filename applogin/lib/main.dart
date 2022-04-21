import 'dart:async';
import 'dart:convert';

import 'package:applogin/pages/page_login/PageLogin.dart';
import 'package:applogin/repository/db_manager.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runZonedGuarded(
    ()=>runApp(const MyApp()),
    (error, stack) => FirebaseCrashlytics.instance.recordError(error,stack,reason: "Error en zona segura"));
}

class MyApp extends StatefulWidget {

  
   // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  

  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  late Future<void> _firebase;

  Future<void> initiliazeFB() async{
    await Firebase.initializeApp();
    await initiliazeCrashlytics();
    await initiliazeRemoteConfig();
    await initiliazeCloudMessage();
    await initializeRealTime();
    
    await DbManager.shared.deleteDb();  
  }

  Future<void> initializeRealTime() async {
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>inicio');
    FirebaseDatabase database = FirebaseDatabase.instance;

        DatabaseReference ref = database.ref("mode");
        ref.onValue.listen((DatabaseEvent event) {  
          final data = event.snapshot.child("theme").value as String;

          if (data == "claro"){
            MyApp.themeNotifier.value = ThemeMode.light;
          }else{
            MyApp.themeNotifier.value = ThemeMode.dark;
          }
          
          print("el valor de la data es ${data}");
        });
  }

  Future<void> initiliazeCrashlytics() async{
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    FlutterError.onError = (FlutterErrorDetails errorDetails) async{
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

  }

  Future<void> initiliazeRemoteConfig() async{
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    //remoteConfig.setDefaults({'contrasena':1234});
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds:10),
      minimumFetchInterval:Duration.zero
    ));
    await remoteConfig.fetchAndActivate();

  }

  Future<void> initiliazeCloudMessage() async{
    FirebaseMessaging cloudMessagin = FirebaseMessaging.instance;

    String token = await cloudMessagin.getToken()??"";
      print(">>>>>>>>>>>>>>>>>>>>>>>>El token para esta app es: ");
      print(token);

    FirebaseMessaging.onMessage.listen((event) {

        print(">>>>>>>>>>>>>>>>>>>>>>>>LLego un mensaje: ");
        print(event.notification!.title);
      

      if(event.notification!.title == "GenerarError"){
        FirebaseCrashlytics.instance.log("Error Generado");
        FirebaseCrashlytics.instance.log(event.notification!.body!);
        FlutterError.reportError(FlutterErrorDetails(
          exception: "Recibio mensaje y genero error",
          context: ErrorSummary('Ejecutado cuando recibio mensaje de CloudMessaging'),
        ));
        FirebaseCrashlytics.instance.crash();         
      }

    });
  }

  @override
  void initState(){
    super.initState();
    dotenv.load();
    _firebase = initiliazeFB();
    
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebase,
      builder: (context, snapshot) {

        return ValueListenableBuilder<ThemeMode>(
            valueListenable: MyApp.themeNotifier,
            builder: (_, ThemeMode currentMode, __) {
              return  MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                     // Define the default brightness and colors.
                  brightness: Brightness.light,
                  primaryColor: Color.fromARGB(255, 179, 208, 231),
                  primaryColorLight: Colors.orange,
                  primaryColorDark: Colors.blue,

                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.green
                  ),
                  textTheme: const TextTheme(
                    headline1: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
                    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                  ),

                ),
                darkTheme: ThemeData(
                     // Define the default brightness and colors.
                  brightness: Brightness.dark,
                  primaryColor: Color.fromARGB(255, 124, 3, 3),
                  primaryColorLight: Color.fromARGB(255, 170, 162, 151),
                  primaryColorDark: Color.fromARGB(255, 80, 24, 41),

                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Color.fromARGB(255, 101, 129, 102)
                  ),
                  
                  // Define the default font family.
                  fontFamily: 'Georgia',

                  // Define the default `TextTheme`. Use this to specify the default
                  // text styling for headlines, titles, bodies of text, and more.
                  textTheme: const TextTheme(
                    headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Colors.white),
                    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                  ),
                ),
                themeMode: currentMode,
                home: PageLogin(),
              );
            }
        );

       
      },
    );
  }
}
