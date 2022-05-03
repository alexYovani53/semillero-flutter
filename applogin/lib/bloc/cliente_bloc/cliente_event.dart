
part of 'cliente_bloc.dart';

abstract class ClienteEvent extends Equatable{
  const ClienteEvent();
  @override
  List<Object?> get props => [];
}


class AgregarClienteEvent extends ClienteEvent{}

class VerClienteEvent extends ClienteEvent{
  final Cliente client;

  VerClienteEvent({required this.client});

  @override
  List<Object?> get props => [client];
  
}

class ElimnarClienteEvent extends ClienteEvent{
  final int dniCl;

  ElimnarClienteEvent({required this.dniCl});

  
  @override
  List<Object?> get props => [dniCl];
  
}

class SalirRegistroClienteEvent extends ClienteEvent{}
