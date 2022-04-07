part of 'basic_bloc.dart';

abstract class BasicEvent extends Equatable{
  const BasicEvent();
}

class ButtonPressed extends BasicEvent{
  @override
  List<Object?> get props => [];
}

class LoginEvent extends BasicEvent{

  final String data;

  LoginEvent({required this.data});

  @override
  List<Object?> get props => [data];
}