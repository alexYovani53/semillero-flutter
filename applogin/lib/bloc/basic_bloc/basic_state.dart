part of 'basic_bloc.dart';

abstract class BasicState extends Equatable{
  bool logeado = false;

  BasicState({
    required this.logeado
  });

  bool get isLogeado => logeado;
}

class AppStarted extends BasicState{
  AppStarted({required bool logeado}) : super(logeado: logeado);

  @override
  List<Object?> get props => [logeado];

}

class LogOutState extends BasicState{
  LogOutState({required bool logeado}) : super(logeado: logeado);
  
  @override
  List<Object?> get props => [logeado];
}

class LogExitosoState extends BasicState{

  final String title;
  LogExitosoState({required this.title, required bool logeado}) : super(logeado: logeado);
  
  @override
  List<Object?> get props => [logeado,title];
}
