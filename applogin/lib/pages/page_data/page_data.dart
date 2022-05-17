
import 'package:applogin/provider/api_manager.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PageDAta extends StatelessWidget {
  const PageDAta({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:ApiManager.shared.request(baseUrl: '192.168.1.70:8585', uri: "/cliente/GetAll", type: HttpType.GET ),
        builder: (BuildContext context, AsyncSnapshot snapshot){

          switch (snapshot.connectionState){

            case ConnectionState.waiting:
            case ConnectionState.none:
              return CircularProgressIndicator();

            case ConnectionState.active:
            case ConnectionState.done:
            default:             
              if (snapshot.hasData){
                final  client = snapshot.requireData;
              }
              return Container();
          }

        }
      )
    );
  }
}