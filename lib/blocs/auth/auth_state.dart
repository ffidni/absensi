part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUpdateUserByAdminSuccess extends AuthState {}

class AuthDeleteUserSuccess extends AuthState {}

class AuthUpdateUserSuccess extends AuthState {
  final UserModel user;

  const AuthUpdateUserSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthFailed extends AuthState {
  final ErrorException error;

  const AuthFailed(this.error);

  @override
  List<Object> get props => [error];
}
