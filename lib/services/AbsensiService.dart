import 'dart:convert';

import 'package:absensi/models/forms/absen_form_model.dart';
import 'package:absensi/models/page_fetchs/kehadiran_fetchs_model.dart';
import 'package:absensi/models/tables/absen_model.dart';
import 'package:absensi/services/AuthService.dart';
import 'package:dio/dio.dart';
import 'package:absensi/shared/shared_class.dart';
import 'package:absensi/shared/shared_values.dart';

class AbsensiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: apiBaseUrl,
  ));

  AbsensiService() {
    _dio.interceptors.add(CustomDioInterceptor());
  }

  Future<List<AbsenModel>> getAllAbsen({String? date, int? userId}) async {
    try {
      String url = "/absensi";
      if (date != null) {
        url = "$url?date=$date";
        if (userId != null) {
          url = "$url&user_id=$userId";
        }
      } else if (userId != null) {
        url = "$url?user_id=$userId";
      }

      final res = await _dio.get(
        url,
      );
      return List.from(res.data['data'])
          .map((e) => AbsenModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<KehadiranFetchsModel> getLaporanKehadiran(int userId) async {
    try {
      final res = await _dio.get(
        "/laporan-kehadiran/$userId",
      );
      return KehadiranFetchsModel.fromJson(res.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAbsen(AbsenFormModel data) async {
    try {
      final res = await _dio.post(
        "/absensi",
        data: data.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editAbsen(int id, AbsenFormModel data) async {
    try {
      final res = await _dio.put(
        "/absensi/$id",
        data: data.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAbsen(int id) async {
    try {
      final res = await _dio.delete(
        "/absensi/$id",
      );
    } catch (e) {
      rethrow;
    }
  }
}
