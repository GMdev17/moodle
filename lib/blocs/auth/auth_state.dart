part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserRole role;

  Authenticated(this.role);
}

class Autherror extends AuthState {
  final String message;

  Autherror(this.message);
}
