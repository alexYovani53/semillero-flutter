
part of 'seguro_bloc.dart';

abstract class SeguroEvent extends Equatable{
  const SeguroEvent();
  @override
  List<Object?> get props => [];
}


class AgregarSeguroEvent extends SeguroEvent{}

class VerSeguroEvent extends SeguroEvent{

  Seguro seguro;
  
  VerSeguroEvent({
    required this.seguro
  });
  
  @override
  List<Object?> get props => [seguro];

}

class ElimnarSeguroEvent extends SeguroEvent{

  final int numberPoliza;

  ElimnarSeguroEvent({
    required this.numberPoliza
  });

  @override
  List<Object?> get props => [numberPoliza];

}

class SalirRegistroSeguroEvent extends SeguroEvent{}
