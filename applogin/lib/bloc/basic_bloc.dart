
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:applogin/repository/realtime_repository.dart';
import 'package:firebase_database/firebase_database.dart';

part 'basic_event.dart';
part 'basic_state.dart';

class BasicBloc extends Bloc<BasicEvent,BasicState>{


  BasicBloc(): super(AppStarted()){

    on<ButtonPressed>((event, emit) => {
      emit(PageChanged(title: "Hola mundo"))
    });

    on<LoginEvent>((event,emit)=>{
      emit(PageChanged(title: event.data))
    });

    
  }


}