import 'dart:convert';

import 'package:absensi/shared/shared_class.dart';
import 'package:absensi/shared/shared_values.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:dio/dio.dart";

String formatIndonesianDate(DateTime dateTime, {bool hideDays = false}) {
  final List<String> monthNamesIndonesian = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  int day = dateTime.day;
  String month = monthNamesIndonesian[dateTime.month];
  int year = dateTime.year;

  return '${hideDays ? '' : day} $month $year';
}

dynamic getColorForBackground(Color? backgroundColor, {bool isText = true}) {
  if (backgroundColor == null) {
    return isText ? blackText : blackColor;
  }

  final double luminance = backgroundColor.computeLuminance();
  if (luminance > 0.5) {
    if (isText) return blackText;
    return blackColor;
  }
  return isText ? whiteText : whiteColor;
}

Future<void> showSnackbar(BuildContext context, String message,
    {isError = true}) async {
  await Flushbar(
    backgroundColor: isError ? redErrorColor : greenColor,
    message: message,
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}

String formatDateAndTime(String datetime) {
  List<String> days = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];
  DateTime parsedDatetime = DateTime.parse(datetime);
  String formattedTime = DateFormat("h:mm a").format(parsedDatetime);

  return "${days[parsedDatetime.weekday - 1]}, ${formatIndonesianDate(parsedDatetime)} ${formattedTime}";
}

dynamic getFormText(GlobalKey<FormBuilderState> key, String name,
    {toString = true}) {
  if (toString) {
    return key.currentState!.fields[name]!.value?.toString() ?? '';
  }
  return key.currentState!.fields[name]!.value;
}

void updateFormText(
  GlobalKey<FormBuilderState> key,
  String name,
  String newVal,
) {
  final formState = key.currentState;
  if (formState != null) {
    final field = formState.fields[name];
    field!.didChange(newVal);
  }
}

String getTimePeriod() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 3 && hour < 12) {
    return 'pagi';
  } else if (hour >= 12 && hour < 15) {
    return 'siang';
  } else if (hour >= 15 && hour < 18) {
    return 'sore';
  } else {
    return 'malam';
  }
}

String convertMinutesToTimeFormat(int minutes) {
  if (minutes < 0) {
    return "Masukan tidak valid"; // Handle negative input, if necessary
  }

  int hours = minutes ~/ 60;
  int remainingMinutes = minutes % 60;

  // Construct the time format string
  String timeFormat = "";

  if (hours > 0) {
    timeFormat += "$hours jam ";
  }

  if (remainingMinutes > 0) {
    timeFormat += "$remainingMinutes menit";
  }

  return timeFormat.trim();
}

int getDayOfMonth() {
  // Get the current date
  DateTime currentDate = DateTime.now();

  // Get the day of the month (1-31)
  int dayOfMonth = currentDate.day;

  return dayOfMonth;
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

Future<String?> getToken() async {
  final dio = Dio();
  const storage = FlutterSecureStorage();
  try {
    String? token = await storage.read(key: "token");
    print(token);
    if (token == null) return null;

    token = 'Bearer $token';
    bool tokenExpired = await isTokenExpired();
    print("token expired: $tokenExpired");
    // print(token);
    if (tokenExpired) {
      print("HEY");
      final res = await dio.get(
        "$apiBaseUrl/refresh-token",
        options: Options(headers: {"Authorization": token}),
      );
      print(res.data);
      final decodedBody = res.data;
      if (res.statusCode! >= 300) {
        throw ErrorException(
          decodedBody["message"],
          data: decodedBody['data'],
          statusCode: res.statusCode,
          requestOptions: RequestOptions(),
        );
      }
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
    if (e is DioException) {
      if (e.response!.data['status'] == 500) {
        await storage.delete(key: "token");
      }
    }
    return null;
  }
}
