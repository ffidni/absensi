import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/absen_page.dart';
import 'package:absensi/ui/karyawan_page.dart';
import 'package:absensi/ui/kehadiran_page.dart';
import 'package:absensi/ui/login_page.dart';
import 'package:absensi/ui/profile_page.dart';
import 'package:absensi/ui/register_page.dart';
import 'package:absensi/ui/tab_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: blackText,
        ),
        iconTheme: IconThemeData(
          color: blackColor,
        ),
        primaryColor: yellowColor,
        errorColor: redErrorColor,
        colorScheme: ColorScheme.light(
          primary: yellowColor,
          onPrimary: whiteColor,
        ),
        scaffoldBackgroundColor: greyBgColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: blackColor),
          titleTextStyle:
              blackText.copyWith(fontSize: 24, fontWeight: semiBold),
          centerTitle: true,
        ),
      ),
      initialRoute: "/register",
      routes: {
        "/register": (context) => RegisterPage(),
        "/login": (context) => LoginPage(),
        "/absen": (context) => AbsenPage(),
        "/kehadiran": (context) => KehadiranPage(),
        "/profile": (context) => ProfilePage(),
        "/karyawan": (context) => KaryawanPage(),
        "/tab": (context) => TabPage(),
      },
    );
  }
}
