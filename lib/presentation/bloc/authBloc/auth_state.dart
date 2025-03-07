part of 'auth_bloc.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final bool isLoggedIn;

  AuthSuccessState(this.isLoggedIn);
}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}

class AuthLoggedOutState extends AuthState {}
