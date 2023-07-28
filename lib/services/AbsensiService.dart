import 'dart:convert';

import 'package:absensi/models/forms/absen_form_model.dart';
import 'package:absensi/models/page_fetchs/kehadiran_fetchs_model.dart';
import 'package:absensi/models/tables/absen_model.dart';
import 'package:absensi/services/AuthService.dart';
import 'package:absensi/shared/shared_class.dart';
import 'package:absensi/shared/shared_values.dart';
import "package:http/http.dart" as http;

class AbsensiService {
  Future<List<AbsenModel>> getAllAbsen({String? date, int? userId}) async {
    try {
      final token = await AuthService().getToken();
      String url = "$apiBaseUrl/absensi";
      if (date != null) {
        url = "$url?date=$date";
        if (userId != null) {
          url = "$url&user_id=$userId";
        }
      } else if (userId != null) {
        url = "$url?user_id=$userId";
      }
      final res = await http.get(
        Uri.parse(url),
        headers: {"Authorization": token},
      ).timeout(const Duration(seconds: 10));
      final decodedBody = jsonDecode(res.body);
      if (res.statusCode >= 300) throw ErrorException(decodedBody['messages']);
      return List.from(decodedBody['data'])
          .map((e) => AbsenModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<KehadiranFetchsModel> getLaporanKehadiran(int userId) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse("$apiBaseUrl/laporan-kehadiran/$userId"),
        headers: {"Authorization": token},
      ).timeout(const Duration(seconds: 10));
      final decodedBody = jsonDecode(res.body);
      if (res.statusCode >= 300) {
        throw ErrorException(
          decodedBody["message"],
          data: decodedBody['data'],
          statusCode: res.statusCode,
        );
      }
      return KehadiranFetchsModel.fromJson(decodedBody['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAbsen(AbsenFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(
        Uri.parse("$apiBaseUrl/absensi"),
        body: data.toJson(),
        headers: {"Authorization": token},
      ).timeout(const Duration(seconds: 10));
      final decodedBody = jsonDecode(res.body);
      if (res.statusCode >= 300) {
        throw ErrorException(
          decodedBody["message"],
          data: decodedBody['data'],
          statusCode: res.statusCode,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editAbsen(int id, AbsenFormModel data) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.put(
        Uri.parse("$apiBaseUrl/absensi/$id"),
        body: data.toJson(),
        headers: {"Authorization": token},
      ).timeout(const Duration(seconds: 10));
      final decodedBody = jsonDecode(res.body);
      if (res.statusCode >= 300) {
        throw ErrorException(
          decodedBody["message"],
          data: decodedBody['data'],
          statusCode: res.statusCode,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAbsen(int id) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.delete(
        Uri.parse("$apiBaseUrl/absensi/$id"),
        headers: {"Authorization": token},
      ).timeout(const Duration(seconds: 10));
      final decodedBody = jsonDecode(res.body);
      if (res.statusCode >= 300) {
        throw ErrorException(
          decodedBody["message"],
          data: decodedBody['data'],
          statusCode: res.statusCode,
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
