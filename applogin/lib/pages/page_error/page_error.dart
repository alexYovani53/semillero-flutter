
import 'package:applogin/widgets/encabezado_pages.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class PageError extends StatelessWidget {

  final String title;  

  const PageError({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          EncabezadoPages(titulo: "Generador Error"),
          Center(
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
                        
                        FirebaseCrashlytics.instance.crash();
                        
                  }

                  //FirebaseCrashlytics.instance.crash();
                }, 
                child: Text('Generar error')),
          )
        ])
    );
  }


}
