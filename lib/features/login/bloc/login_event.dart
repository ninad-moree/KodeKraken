part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {}

class StudentLoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;

  StudentLoginButtonClickedEvent(this.email, this.password);
}

class TeacherLoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;

  TeacherLoginButtonClickedEvent(this.email, this.password);
}
