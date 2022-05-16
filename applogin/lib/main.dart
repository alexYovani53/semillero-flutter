import 'dart:async';
import 'package:applogin/bloc/basic_bloc/basic_bloc.dart';
import 'package:applogin/bloc/bloc_observer/simple_bloc_observer.dart';
import 'package:applogin/localizations/localizations.dart';
import 'package:applogin/pages/page_login/page_init.dart';
import 'package:applogin/provider/languaje_provider.dart';
import 'package:applogin/provider/themeProvider.dart';
import 'package:applogin/repository/db_manager.dart';
import 'package:applogin/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';

void main() {
  BlocOverrides.runZoned(
    ()=>runZonedGuarded(
      ()=>runApp(
            MultiBlocProvider(
              providers: [BlocProvider(create: (context) => BasicBloc())],
              child: const MyApp(),
            )
          ),
      (error, stack) => FirebaseCrashlytics.instance.recordError(error,stack,reason: "Error en zona segura")
    ),
    blocObserver:BlocObserverApp() 
  );
}

class MyApp extends StatefulWidget {

  //static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  static bool connected = false;

  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  late Future<void> _firebase;
  ThemeProvider themeProvider_ = ThemeProvider();
  LanguajeProvider langProvider = LanguajeProvider();

  Future<void> initiliazeFB() async{
    await initthemeconfig();
    await initlanguajeconfig();
    await Firebase.initializeApp();
    await initiliazeCrashlytics();
    await initiliazeRemoteConfig();
    await initiliazeCloudMessage();
    await initializeRealTime();
    await DbManager.shared.deleteDb();  
  }

  Future<void> initthemeconfig() async{
    themeProvider_.setTheme = await themeProvider_.getInitTheme();
  }

  Future<void> initlanguajeconfig() async{
    langProvider.setLanguaje = await langProvider.getLocaleinit();
  }

  Future<void> initializeRealTime() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref("mode");
    ref.onValue.listen((DatabaseEvent event) {            
      final data = event.snapshot.child("theme").value as String;
      if (data == "claro"){
        //MyApp.themeNotifier.value = ThemeMode.light;
        themeProvider_.setTheme = ThemeMode.light;
      }else{
        //MyApp.themeNotifier.value = ThemeMode.dark;
        themeProvider_.setTheme = ThemeMode.dark;
      }
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
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds:10),
      minimumFetchInterval:Duration.zero
    ));
    await remoteConfig.fetchAndActivate();
  }

  Future<void> initiliazeCloudMessage() async{
    FirebaseMessaging cloudMessagin = FirebaseMessaging.instance;
    String token = await cloudMessagin.getToken()??"";

    FirebaseMessaging.onMessage.listen((event) {
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
    dotenv.load();
    _firebase = initiliazeFB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebase,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          
        return MultiProvider(
          providers: [
            //ChangeNotifierProvider(create: (_)=>LanguajeProvider()),
            ChangeNotifierProvider.value(value: langProvider),
            ChangeNotifierProvider.value(value: themeProvider_)
          ],
          child: Consumer2<LanguajeProvider, ThemeProvider>(
            builder: (context,LanguajeProvider languajeProvider, ThemeProvider themeProvider, child) {
                                return  MaterialApp(
                    locale: languajeProvider.getLanguaje,
                    localizationsDelegates: const [
                      AppLocalizationsDelegate(),
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('es', ''),
                      Locale('en', ''),
                    ],
                    title: 'Flutter Demo',
                    debugShowCheckedModeBanner: false,
                    themeMode:themeProvider_.getTheme,
                    theme: AppThemes.claro,
                    darkTheme: AppThemes.obscuro,
                    home: OfflineBuilder(
                      connectivityBuilder: (context, connectivity, child) {
                          MyApp.connected =  connectivity != ConnectivityResult.none;
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  height: 24.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    color: MyApp.connected
                                        ? Color(0xFF00EE44)
                                        : Color(0xFFEE4400),
                                    child: Center(
                                      child: Text(
                                          "${MyApp.connected ? 'ONLINE' : 'OFFLINE'}"),
                                    ),
                                  ),
                                ),
                                Scaffold(
                                  body: child,
                                ),
                              ],
                            );
                      },
                      // child: Prueba(),
                      child: PageInit()
                      //child: PageSetting(),
                    ),
                  );
               
            },
          ),
        );     
     
        }else{
          return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  // Widget run2(){
  //   return FutureBuilder(
  //     future: _firebase,
  //     builder: (context, snapshot) {

  //       return ValueListenableBuilder<ThemeMode>(
  //           valueListenable: MyApp.themeNotifier,
  //           builder: (_, ThemeMode currentMode, __) {
  //             return  MaterialApp(
  //               title: 'Flutter Demo',
  //               debugShowCheckedModeBanner: false,
  //               theme: ThemeData(
  //                 primarySwatch: Colors.blue,
  //                 visualDensity: VisualDensity.adaptivePlatformDensity,
  //               ),
  //               themeMode: currentMode,
  //               home: OfflineBuilder(
  //                 connectivityBuilder: (context, connectivity, child) {
  //                     MyApp.connected =  connectivity != ConnectivityResult.none;
  //                       return Stack(
  //                         fit: StackFit.expand,
  //                         children: [
  //                           Positioned(
  //                             height: 24.0,
  //                             left: 0.0,
  //                             right: 0.0,
  //                             child: Container(
  //                               color: MyApp.connected
  //                                   ? Color(0xFF00EE44)
  //                                   : Color(0xFFEE4400),
  //                               child: Center(
  //                                 child: Text(
  //                                     "${MyApp.connected ? 'ONLINE' : 'OFFLINE'}"),
  //                               ),
  //                             ),
  //                           ),
  //                           Scaffold(
  //                             body: child,
  //                           ),
  //                         ],
  //                       );
  //                 },
  //                 // child: Prueba(),
  //                 child: PageInit()

  //               ),
  //             );
  //           }
  //       );     
  //     },
  //   );
  // }


}
