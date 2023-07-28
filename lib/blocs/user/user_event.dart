part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetAllKaryawan extends UserEvent {}

class UserResetState extends UserEvent {}

class UserCreate extends UserEvent {
  final RegisterFormModel data;

  const UserCreate(this.data);

  @override
  List<Object> get props => [data];
}

class UpdateUser extends UserEvent {
  final int userId;
  final RegisterFormModel data;

  const UpdateUser(this.userId, this.data);

  @override
  List<Object> get props => [userId, data];
}

class UpdateUserByAdmin extends UserEvent {
  final int userId;
  final RegisterFormModel data;

  const UpdateUserByAdmin(this.userId, this.data);

  @override
  List<Object> get props => [userId, data];
}

class DeleteUser extends UserEvent {
  final List<int> ids;

  const DeleteUser(this.ids);

  @override
  List<Object> get props => [ids];
}
