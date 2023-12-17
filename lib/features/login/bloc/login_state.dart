part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Student? student;
  final Teacher? teacher;
  LoginSuccess({this.teacher, this.student});
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}
