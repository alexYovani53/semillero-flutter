import 'package:applogin/bloc/cliente_bloc/cliente_bloc.dart';
import 'package:applogin/main.dart';
import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/pages/page_client/client_data.dart';
import 'package:applogin/provider/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ClientView extends StatefulWidget {
  
  Cliente cliente;  
  Function(Cliente client) navegar;

  ClientView({Key? key,     
    required this.cliente,
    required this.navegar
  }) : super(key: key);


  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {


  @override
  Widget build(BuildContext context) {

    final ThemeProvider theme =Provider.of<ThemeProvider>(context);
    return Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                left: 10.0,
                right:10.0
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.00)),
                gradient:  LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                          theme.getTheme == ThemeMode.light? Color.fromARGB(255, 243, 237, 229):Color(0xFF485563),
                          theme.getTheme == ThemeMode.light? Color.fromARGB(255, 96, 231, 72):Color(0xFF29323C),
                    ],
                  )
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top:5.0,
                      left: 5.0,
                      bottom: 5.0
                    ),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/cliente.png")
                      )
                    ),
                    width: 80.0,
                    height: 80.0
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 20.0
                          ),
                          child: Text(
                            widget.cliente.nombreCl + " "+ widget.cliente.apellido1 + " " + widget.cliente.apellido2,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize:  17.0
                            )
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 20.0
                          ),
                          child: Text(
                            widget.cliente.ciudad,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize:  12.0
                            )
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 20.0
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.cliente.telefono.toString(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize:  15.0
                                )
                              ),
                              Text(
                                widget.cliente.clienteNewColumn?? ""
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Center(
                        child: FloatingActionButton(
                          heroTag: widget.cliente.dniCl,
                          child:  Icon(
                            Icons.arrow_forward,
                            size: 50.0,
                          ),
                          onPressed: (){                            
                            widget.navegar(widget.cliente);
                          },
                        ),
                      ),
                    ),
                  )

                ],
              )
          
            );      
  }
}