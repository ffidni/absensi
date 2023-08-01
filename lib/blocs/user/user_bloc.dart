import 'package:absensi/models/forms/register_form_model.dart';
import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/services/AuthService.dart';
import 'package:absensi/shared/shared_class.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        if (event is UpdateUser) {
          await _handleUpdateUser(event.userId, event.data, emit);
        } else if (event is UpdateUserByAdmin) {
          await _handleUpdateUser(event.userId, event.data, emit, admin: true);
        } else if (event is DeleteUser) {
          await _handleDeleteUser(event.ids, emit);
        } else if (event is GetAllKaryawan) {
          await _handleGetAllKaryawan(emit);
        } else if (event is UserCreate) {
          await _handleCreate(event.data, emit);
        }
      } catch (e) {
        emit(UserFailed(
            ErrorException(e.toString(), requestOptions: RequestOptions())));
      }
    });
  }
}

Future<void> _handleGetAllKaryawan(Emitter<UserState> emit) async {
  try {
    final List<UserModel> karyawan = await AuthService().getAllKaryawan();

    emit(UserGetKaryawanSuccess(karyawan));
  } catch (e) {
    rethrow;
  }
}

Future<void> _handleCreate(RegisterFormModel data, Emitter<UserState> emit,
    {bool admin = false}) async {
  final UserModel user = await AuthService().register(data, isAdmin: true);
  emit(UserCreateSuccess(user));
}

Future<void> _handleUpdateUser(
    int userId, RegisterFormModel data, Emitter<UserState> emit,
    {bool admin = false}) async {
  final UserModel user =
      await AuthService().updateUser(userId, data, admin: admin);
  emit(admin ? UserUpdateUserByAdminSuccess() : UserUpdateUserSuccess(user));
}

Future<void> _handleDeleteUser(List<int> ids, Emitter<UserState> emit) async {
  for (var id in ids) {
    await AuthService().deleteUser(id);
  }
  emit(UserDeleteUserSuccess());
}
