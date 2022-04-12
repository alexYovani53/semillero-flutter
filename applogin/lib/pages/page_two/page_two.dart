import 'package:applogin/main.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final String title;

  const PageTwo({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(this.title),
        actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              })
        ],
      ),

      body: Center(
        child:  ElevatedButton(
            onPressed: (){

              FirebaseCrashlytics.instance.setCustomKey("Usuario", FirebaseRemoteConfig.instance.getString("correo"));
              FirebaseCrashlytics.instance.log("Generando error");

              try {                
                throw ("Estamos en pagina 2");
              } catch (e) {
                    FlutterError.reportError(FlutterErrorDetails(
                      exception: e,
                      library: 'Flutter framework',
                      context: ErrorSummary('Presionando un boton '),
                    ));
                    
                    
              }

              //FirebaseCrashlytics.instance.crash();
            }, 
            child: Text('Generar error')),
      )
    );
  }
}
