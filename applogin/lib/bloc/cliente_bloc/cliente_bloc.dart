

import 'package:applogin/model/cliente/cliente.dart';
import 'package:applogin/provider/api_cliente_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'cliente_event.dart';
part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent,ClienteState> {

  ClienteBloc() : super(InicioClienteState()){

    on<AgregarClienteEvent>((event, emit) => emit(AgregarClientState()));

    
    on<ElimnarClienteEvent>((event, emit) async  {
        await ApiClienteProvider.shared.eliminarCliente(event.dniCl);


        await Future.delayed(const Duration(seconds: 2), () {
          emit(EliminarClienteState(dniCl: event.dniCl));
        });     
    });

    on<VerClienteEvent>((event, emit) => emit(
      VerClienteState(client: event.client))
    );
  
    on<SalirRegistroClienteEvent>((event,  emit) => emit(RegresarAPageState()));
  }

  
}