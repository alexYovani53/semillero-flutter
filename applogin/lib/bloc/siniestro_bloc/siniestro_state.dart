
part of 'siniestro_bloc.dart';

abstract class SiniestroState {}

class Inicio extends SiniestroState{}

class InitialSiniestroState extends SiniestroState{}

class AgregarSiniestroState extends SiniestroState{}

class EliminarSiniestroState extends SiniestroState{

  final int idSiniestro;

  EliminarSiniestroState({required this.idSiniestro});

  
  @override
  List<Object?> get props => [idSiniestro];
  
}

class RegresarAPageState extends SiniestroState{}

class VerSiniestroState extends SiniestroState{
  Siniestro siniestro;

  VerSiniestroState({
    required this.siniestro
  });
  
  @override
  List<Object?> get props => [siniestro];
}
