part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final UserRole role;

  AuthSignUpRequested(this.email, this.password, this.role);
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested(this.email, this.password);
}

class AuthCheckRole extends AuthEvent {
  final String uid;

  AuthCheckRole(this.uid);
}
