
part of 'cliente_bloc.dart';

abstract class ClienteState {}

class Inicio extends ClienteState{}

class InitialClientState extends ClienteState{}

class AgregarClientState extends ClienteState{}

class EliminarClienteState extends ClienteState{
    final int dniCl;

  EliminarClienteState({required this.dniCl});

  
  @override
  List<Object?> get props => [dniCl];
  
}

class RegresarAPageState extends ClienteState{}

class VerClienteState extends ClienteState{
  
  Cliente client;
  VerClienteState({required this.client});
  
    @override
  List<Object> get props => [client];

}
