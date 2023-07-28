part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserUpdateUserByAdminSuccess extends UserState {}

class UserDeleteUserSuccess extends UserState {}

class UserGetKaryawanSuccess extends UserState {
  final List<UserModel> karyawan;
  const UserGetKaryawanSuccess(this.karyawan);

  @override
  List<Object> get props => [karyawan];
}

class UserUpdateUserSuccess extends UserState {
  final UserModel user;

  const UserUpdateUserSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserFailed extends UserState {
  final ErrorException error;

  const UserFailed(this.error);

  @override
  List<Object> get props => [error];
}
