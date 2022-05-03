
part of 'siniestro_bloc.dart';

abstract class SiniestroEvent extends Equatable{
  const SiniestroEvent();
  @override
  List<Object?> get props => [];
}


class AgregarSiniestroEvent extends SiniestroEvent{}

class VerSiniestroEvent extends SiniestroEvent{

  Siniestro siniestro;

  VerSiniestroEvent({
    required this.siniestro
  });
  
  @override
  List<Object?> get props => [siniestro];

}

class ElimnarSiniestroEvent extends SiniestroEvent{
  final int idSiniestro;

  ElimnarSiniestroEvent({required this.idSiniestro});

  
  @override
  List<Object?> get props => [idSiniestro];
  
}

class SalirRegistroSiniestroEvent extends SiniestroEvent{}
