part of 'auth_bloc.dart';

abstract class AuthEvent {}

class CreateAccountEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  CreateAccountEvent(this.name, this.email, this.password);
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class CheckAuthStatusEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
