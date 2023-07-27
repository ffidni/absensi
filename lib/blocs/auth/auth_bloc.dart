import 'package:absensi/models/forms/login_form_model.dart';
import 'package:absensi/models/forms/register_form_model.dart';
import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/services/AuthService.dart';
import 'package:absensi/shared/shared_class.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GlobalKey<NavigatorState> navigatorKey;

  AuthBloc(this.navigatorKey) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      try {
        emit(AuthLoading());
        if (event is AuthLogin) {
          await _handleLogin(event.data, emit);
        } else if (event is AuthGetUserByToken) {
          await _handleGetUserByToken(emit);
        } else if (event is AuthRegister) {
          await _handleRegister(event.data, emit);
        } else if (event is AuthLogout) {
          await _handleLogout(emit, navigatorKey);
        } else if (event is AuthUpdateUser) {
          _handleUpdateUser(event.data, emit);
        }
      } catch (e) {
        if (e is ErrorException) {
          if (e.statusCode == 401) {
            if (e.message != "Authorization code is not found") {
              _handleLogout(emit, navigatorKey);
            } else {
              emit(AuthInitial());
              navigatorKey.currentState!
                  .pushNamedAndRemoveUntil("/login", (route) => false);
            }
          } else {
            emit(AuthFailed(e));
          }
        } else {
          emit(AuthFailed(ErrorException(e.toString())));
        }
      }
    });
  }
}

void _handleUpdateUser(UserModel data, Emitter<AuthState> emit) {
  emit(AuthSuccess(data));
}

Future<void> _handleGetUserByToken(Emitter<AuthState> emit) async {
  final UserModel user = await AuthService().getUserByToken();
  print(user);
  emit(AuthSuccess(user));
}

Future<void> _handleLogin(LoginFormModel data, Emitter<AuthState> emit) async {
  final UserModel user = await AuthService().login(data);
  emit(AuthSuccess(user));
}

Future<void> _handleRegister(
    RegisterFormModel data, Emitter<AuthState> emit) async {
  final UserModel user = await AuthService().register(data);
  emit(AuthSuccess(user));
}

Future<void> _handleLogout(
    Emitter<AuthState> emit, GlobalKey<NavigatorState> navigatorKey) async {
  await AuthService().logout();
  navigatorKey.currentState!
      .pushNamedAndRemoveUntil("/login", (route) => false);
  emit(AuthInitial());
}
