
part of 'seguro_bloc.dart';

abstract class SeguroState {}

class Inicio extends SeguroState{}

class InitialSeguroState extends SeguroState{}

class AgregarSeguroState extends SeguroState{}

class EliminarSeguroState extends SeguroState{
  final int numberPoliza;

  EliminarSeguroState({
    required this.numberPoliza
  });

  @override
  List<Object?> get props => [numberPoliza];

}

class RegresarAPageState extends SeguroState{}

class VerSeguroState extends SeguroState{
  
  Seguro seguro;
  
  VerSeguroState({
    required this.seguro
  });
  
  @override
  List<Object?> get props => [seguro];

}
