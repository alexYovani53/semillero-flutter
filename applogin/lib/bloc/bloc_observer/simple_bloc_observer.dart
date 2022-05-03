import 'package:bloc/bloc.dart';

class BlocObserverApp extends BlocObserver {


  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("SE CERRO EL BLOC : ${bloc} <<<<<<---->><<<>><<<<<<------------------------------->>>>>--<<");
  }


  @override
  void onCreate(BlocBase bloc){
    super.onCreate(bloc);
    print("SE CREO EL BLOC : ${bloc}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("SE GENERO EL EVENTO -->>>>>>>>>>>>>> $event");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("SE GENERO EL ERROR -->>>>>>>>>>>>>> $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("BLOCK -->>>>>>>>>>>>>>: ${bloc}");
    print("ESTADO ACTUAL: ${change.currentState}");
    print("ESTADO ACTUAL: ${change.nextState}");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("BLOC -->>>>>>>>>>>>>>  $bloc, ESTA EN TRANSICION : $transition");
  }
}
