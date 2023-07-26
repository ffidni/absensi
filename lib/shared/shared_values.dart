import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/absen_page.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> navigationList = [
  {
    "label": "Absensi",
    "icon": const Icon(Icons.check_box, size: 24),
    "tipe_user": "admin",
  },
  {
    "label": "Karyawan",
    "icon": const Icon(Icons.people, size: 24),
    "tipe_user": "admin",
  },
  {
    "label": "Laporan Kehadiran",
    "icon": const Icon(Icons.report, size: 24),
    "tipe_user": "user",
  },
  {
    "label": "Profile",
    "icon": const Icon(Icons.account_circle, size: 24),
    "tipe_user": "user",
  },
];

String apiBaseUrl = "http://10.0.2.2:8000/api";
