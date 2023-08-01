import 'dart:convert';

import 'package:absensi/models/forms/login_form_model.dart';
import 'package:absensi/models/forms/register_form_model.dart';
import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/shared/shared_class.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:absensi/shared/shared_values.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: apiBaseUrl,
  ));

  AuthService() {
    _dio.interceptors.add(CustomDioInterceptor());
  }

  Future<UserModel> login(LoginFormModel data) async {
    try {
      print("A");
      final res = await _dio.post(
        "/login",
        data: data.toJson(),
      );
      print("B");

      final UserModel user = UserModel.fromJson(res.data['data']);
      await storeCredential(user);
      return user;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<UserModel> register(RegisterFormModel data,
      {bool isAdmin = false}) async {
    try {
      String url = "/register";
      if (!isAdmin) {
        url += "?login=true";
      }
      final res = await _dio.post(
        url,
        data: data.toJson(),
      );

      final UserModel user = UserModel.fromJson(res.data['data']);
      if (!isAdmin) {
        await storeCredential(user);
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(int userId, RegisterFormModel data,
      {bool admin = false}) async {
    try {
      final res = await _dio.put(
        "/update-user/$userId",
        data: data.toJson(),
      );

      final UserModel user = UserModel.fromJson(res.data['data']);
      if (!admin) {
        await storeCredential(user);
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getAllKaryawan() async {
    try {
      final res = await _dio.get(
        "/karyawan",
      );

      return List.from(res.data['data'])
          .map((e) => UserModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      final res = await _dio.delete(
        "/delete-user/$userId",
      );

      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredential(UserModel user) async {
    const storage = FlutterSecureStorage();
    try {
      if (user.token != null) {
        await storage.write(key: "token", value: user.token);
      }
      await storage.write(key: "email", value: user.email);
      await storage.write(
          key: "token_expires_in", value: user.tokenExpiresIn.toString());
    } catch (e) {
      throw ErrorException(e.toString(), requestOptions: RequestOptions());
    }
  }

  Future<LoginFormModel> getCredential() async {
    const storage = FlutterSecureStorage();
    Map<String, dynamic> values = await storage.readAll();
    try {
      if (values['email'] == null) throw "!auntheticated";
      return LoginFormModel(
          email: values['email'], password: values['password']);
    } catch (e) {
      throw ErrorException(e.toString(), requestOptions: RequestOptions());
    }
  }

  Future<void> clearCredential() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<UserModel> getUserByToken() async {
    try {
      final res = await _dio.get(
        "/get-user-by-token",
      );

      return UserModel.fromJson(res.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout({bool expired = false}) async {
    try {
      await clearCredential();
      if (!expired) {
        final res = await _dio.post(
          "/logout",
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
