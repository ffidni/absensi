part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
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
  final int userId;

  const DeleteUser(this.userId);

  @override
  List<Object> get props => [userId];
}
