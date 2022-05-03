

import 'package:applogin/model/siniestro/siniestro.dart';
import 'package:applogin/provider/api_siniestro_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'siniestro_event.dart';
part 'siniestro_state.dart';

class SiniestroBloc extends Bloc<SiniestroEvent,SiniestroState> {

  SiniestroBloc() : super(Inicio()){

    on<AgregarSiniestroEvent>((event, emit) => emit(AgregarSiniestroState()));

    
    on<ElimnarSiniestroEvent>((event, emit) async {           
      ApiSiniestroProvider.shared.eliminarSiniestro(event.idSiniestro);
        await Future.delayed(const Duration(seconds: 2), () {          
          emit(EliminarSiniestroState(idSiniestro:  event.idSiniestro)) ;
        });      
    });

    on<VerSiniestroEvent>((event, emit) => emit(VerSiniestroState(
      siniestro: event.siniestro
    )));
  
    on<SalirRegistroSiniestroEvent>((event,  emit) => emit(RegresarAPageState()));
  }

  
}