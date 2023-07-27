import 'package:another_flushbar/flushbar.dart';
import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter_form_builder/flutter_form_builder.dart";

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
    duration: Duration(seconds: 3),
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

String? getFormText(GlobalKey<FormBuilderState> key, String name) {
  return key.currentState!.fields[name]!.value?.toString() ?? '';
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

int getTotalDaysInThisMonth() {
  // Get the current date
  DateTime currentDate = DateTime.now();

  // Get the last day of the current month
  DateTime lastDayOfMonth =
      DateTime(currentDate.year, currentDate.month + 1, 0);

  // Extract the day component to get the total days in the current month
  int totalDaysInThisMonth = lastDayOfMonth.day;

  return totalDaysInThisMonth;
}
