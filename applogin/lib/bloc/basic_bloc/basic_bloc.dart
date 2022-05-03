
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'basic_event.dart';
part 'basic_state.dart';

class BasicBloc extends Bloc<BasicEvent,BasicState>{


  BasicBloc(): super(AppStarted(logeado: false)){

    on<ButtonPressedEvent>((event, emit) => {
      emit(LogExitosoState(title: "Hola mundo",logeado: true))
    });

    on<LoginEvent>((event,emit)=>{
      emit(LogExitosoState(title: event.data,logeado: true))
    });   

    on<LogOutEvent>((event,emit)=>{
      emit(LogOutState(logeado: false))
    });
    
  }


}