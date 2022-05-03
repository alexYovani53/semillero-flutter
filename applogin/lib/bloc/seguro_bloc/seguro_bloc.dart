

import 'package:applogin/model/seguro/seguro.dart';
import 'package:applogin/provider/api_seguro_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seguro_event.dart';
part 'seguro_state.dart';

class SeguroBloc extends Bloc<SeguroEvent,SeguroState> {

  SeguroBloc() : super(InitialSeguroState()){

    on<AgregarSeguroEvent>((event, emit) => emit(AgregarSeguroState()));
    
    on<ElimnarSeguroEvent>((event, emit) async {

      ApiSeguroProvider.shared.eliminarSeguro(event.numberPoliza);
            
        await Future.delayed(const Duration(seconds: 2), () {
          emit(EliminarSeguroState(numberPoliza: event.numberPoliza));
        });  
      
    });

    on<VerSeguroEvent>((event, emit) => emit(VerSeguroState(seguro:event.seguro)));
  
    on<SalirRegistroSeguroEvent>((event,  emit) => emit(RegresarAPageState()));
  }

  
}