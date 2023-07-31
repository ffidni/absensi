import "dart:convert";

import "package:absensi/models/forms/login_form_model.dart";
import "package:absensi/models/forms/register_form_model.dart";
import "package:absensi/models/tables/user_model.dart";
import "package:absensi/shared/shared_class.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;
import "package:absensi/shared/shared_values.dart";

class AuthService {
  Future<UserModel> login(LoginFormModel data) async {
    try {
      print(apiBaseUrl);
      final res = await http
          .post(
            Uri.parse("$apiBaseUrl/login"),
            body: data.toJson(),
          )
          .timeout(const Duration(seconds: 10));
      final decodedBody = jsonDecode(res.body);
      if (res.statusCode >= 300) {
        throw ErrorException(
          decodedBody["message"],
          data: decodedBody['data'],
          statusCode: res.statusCode,
        );
      }
      print(decodedBody['data']);
      final UserModel user = UserModel.fromJson(decodedBody['data']);
      await storeCredential(user);
      print("B $user");

      return user;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<UserModel> register(RegisterFormModel data,
      {bool isAdmin = false}) async {
    try {
      String url = "$apiBaseUrl/register";
      if (!isAdmin) {
        url += "?login=true";
      }
      final res = await http
          .post(
            Uri.parse(url),
            body: data.toJson(),
          )
          .timeout(const Duration(seconds: 10));
      final decodedBody = jsonDecode(res.body);
      print(decodedBody);

      if (res.statusCode >= 300) {
        throw ErrorException(
          decodedBody["message"],
          data: decodedBody['data'],
          statusCode: res.statusCode,
        );
      }
      final UserModel user = UserModel.fromJson(decodedBody['data']);
      if (!isAdmin) {
        await storeCredential(user);
      }
      return user;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserModel> updateUser(int userId, RegisterFormModel data,
      {bool admin = false}) async {
    try {
      final token = await getToken();
      final res = await http.put(
        Uri.parse("$apiBaseUrl/update-user/$userId"),
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
      final UserModel user = UserModel.fromJson(decodedBody['data']);
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
      final token = await getToken();
      final res = await http.get(
        Uri.parse("$apiBaseUrl/karyawan"),
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

      return List.from(decodedBody['data'])
          .map((e) => UserModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      final token = await getToken();
      final res = await http.delete(
        Uri.parse("$apiBaseUrl/delete-user/$userId"),
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
      throw ErrorException(e.toString());
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
      throw ErrorException(e.toString());
    }
  }

  Future<bool> isTokenExpired() async {
    const storage = FlutterSecureStorage();
    String? tokenExpiresString = await storage.read(key: "token_expires_in");
    print(tokenExpiresString);
    if (tokenExpiresString == null) return true;
    int tokenExpiresIn = int.parse(tokenExpiresString);
    print(tokenExpiresIn);

    final DateTime expirationDate =
        DateTime.fromMillisecondsSinceEpoch(tokenExpiresIn * 1000);
    final currentTime = DateTime.now();
    return currentTime.isAfter(expirationDate);
  }

  Future<String> getToken() async {
    try {
      const storage = FlutterSecureStorage();
      String? token = await storage.read(key: "token");
      if (token == null) return '';

      token = 'Bearer $token';
      bool tokenExpired = await isTokenExpired();
      print("token expired: $tokenExpired");
      print(token);
      if (tokenExpired) {
        final res = await http.get(
          Uri.parse("$apiBaseUrl/refresh-token"),
          headers: {"Authorization": token},
        );
        final decodedBody = jsonDecode(res.body);
        if (res.statusCode >= 300) throw decodedBody['message'];

        String newToken = decodedBody['data']['token'];
        String tokenExpiresIn =
            decodedBody['data']['token_expires_in'].toString();
        print("token expired: $tokenExpiresIn");
        await storage.write(key: "token", value: newToken);
        await storage.write(key: "token_expires_in", value: tokenExpiresIn);
        return "Bearer $newToken";
      }
      return token;
    } catch (e) {
      throw ErrorException(e.toString());
    }
  }

  Future<void> clearCredential() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  Future<UserModel> getUserByToken() async {
    try {
      final token = await getToken();
      final res = await http.get(
        Uri.parse("$apiBaseUrl/get-user-by-token"),
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

      return UserModel.fromJson(decodedBody['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await clearCredential(); //fix
      final token = await getToken();
      final res = await http.post(
        Uri.parse("$apiBaseUrl/logout"),
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
