
part of 'cliente_bloc.dart';

abstract class ClienteState extends Equatable{}

class InicioClienteState extends ClienteState{
  @override
  List<Object?> get props => [];
}

class InitialClientState extends ClienteState{
  @override
  List<Object?> get props => [];
}

class AgregarClientState extends ClienteState{
  @override
  List<Object?> get props => [];
}

class EliminarClienteState extends ClienteState{
    final int dniCl;

  EliminarClienteState({required this.dniCl});

  
  @override
  List<Object?> get props => [dniCl];
  
}

class RegresarAPageState extends ClienteState{
  @override
  List<Object?> get props => [];
}

class VerClienteState extends ClienteState{
  
  Cliente client;
  VerClienteState({required this.client});
  
    @override
  List<Object> get props => [client];

}
