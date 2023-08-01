part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRegister extends AuthEvent {
  final RegisterFormModel data;

  const AuthRegister(this.data);

  @override
  List<Object> get props => [data];
}

class AuthLogin extends AuthEvent {
  final LoginFormModel data;

  const AuthLogin(this.data);

  @override
  List<Object> get props => [data];
}

class AuthUpdateUser extends AuthEvent {
  final UserModel data;

  const AuthUpdateUser(this.data);

  @override
  List<Object> get props => [data];
}

class AuthLogout extends AuthEvent {
  bool expired;

  AuthLogout({this.expired = false});

  @override
  List<Object> get props => [expired];
}

class AuthGetUserByToken extends AuthEvent {}
