import 'package:applogin/main.dart';
import 'package:applogin/repository/realtime_repository.dart';
import 'package:applogin/widgets/gradient_back.dart';
import 'package:applogin/widgets/theme_mode_button.dart';
import 'package:flutter/material.dart';

class EncabezadoPages  extends StatelessWidget {

  String titulo = "Clientes";

  EncabezadoPages ({
    Key? key,
    required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
  final realtime = RealTimeRepository();
  
    return 
          Stack(
            children: [
              GradientBack(),
              Container(                
                margin: EdgeInsets.only(top: 40.0,left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        color: Color.fromARGB(248, 23, 110, 223),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0
                      ),
                    ), 
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
                      })
                  ],
                ),
              ),
            ],
          );
  }
}