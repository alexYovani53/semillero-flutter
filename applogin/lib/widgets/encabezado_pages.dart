import 'package:applogin/bloc/basic_bloc/basic_bloc.dart';
import 'package:applogin/main.dart';
import 'package:applogin/pages/page_setting/page_setting.dart';
import 'package:applogin/provider/api_login.dart';
import 'package:applogin/provider/themeProvider.dart';
import 'package:applogin/repository/firebase/realtime_repository.dart';
import 'package:applogin/widgets/gradient_back.dart';
import 'package:applogin/widgets/theme_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';

class EncabezadoPages  extends StatelessWidget {

  String titulo = "Clientes";

  EncabezadoPages ({
    Key? key,
    required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        final ThemeProvider theme =Provider.of<ThemeProvider>(context);
    final BasicBloc bloc = BlocProvider.of<BasicBloc>(context);
    final realtime = RealTimeRepository();
  
    return Stack(
        children: [
          GradientBack(),
          OfflineBuilder(connectivityBuilder: (context, connectivity, child) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Container(         
              decoration: BoxDecoration(
                color: connected?Color.fromARGB(0, 244, 67, 54):  Colors.red 
              ),       
              padding:EdgeInsets.only(top: 40.0,left: 15.0) ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titulo,
                    style: Theme.of(context).textTheme.headline4,
                  ), 
                  
                  IconButton(
                    icon: Icon(Icons.logout),                    
                    hoverColor: Colors.red,
                    onPressed: () {
                      bloc.add(LogOutEvent());
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.close_outlined),
                    onPressed: () async {

                      final response = await ApiLogin.shared.getError403() ;
                      if(response){                        
                        bloc.add(LogOutEvent());
                      }
                    }
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (ctx) => const PageSetting()));
                      }, 
                      icon: Icon(Icons.settings) 
                    ),
                  )
                  // IconButton(
                  //   icon: Icon(theme.getTheme == ThemeMode.light
                  //       ? Icons.dark_mode
                  //       : Icons.light_mode),
                  //   onPressed: () {
                  //     realtime.updateThemeMode();
                  //     theme.setTheme =
                  //         theme.getTheme == ThemeMode.light
                  //             ? ThemeMode.dark
                  //             : ThemeMode.light;
                  //   }
                  // )
                ],
              ),
            );
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'There are no bottons to push :)',
                ),
                new Text(
                  'Just turn off your internet.',
                ),
              ],
          )
        )
      ],
    );
  }
}