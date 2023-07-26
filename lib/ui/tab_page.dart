import 'package:absensi/shared/shared_values.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/absen_page.dart';
import 'package:absensi/ui/karyawan_page.dart';
import 'package:absensi/ui/kehadiran_page.dart';
import 'package:absensi/ui/login_page.dart';
import 'package:absensi/ui/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TabPage extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController();

  TabPage({super.key});

  void openDrawer() {
    _tabKey.currentState!.openEndDrawer();
  }

  List<PersistentBottomNavBarItem> _buildNavItems() {
    return navigationList
        .map(
          (e) => PersistentBottomNavBarItem(
            icon: e['icon'],
            title: e['label'],
            activeColorPrimary: yellowColor,
            inactiveColorPrimary: greyColor,
          ),
        )
        .toList();
  }

  List<Widget> _buildScreens() {
    return [
      AbsenPage(),
      KaryawanPage(),
      KehadiranPage(),
      ProfilePage(),
    ];
  }

  final GlobalKey<ScaffoldState> _tabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _tabKey,
      body: PersistentTabView(
        context,
        controller: _controller,
        confineInSafeArea: true,
        backgroundColor: whiteColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        screens: _buildScreens(),
        items: _buildNavItems(),
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }
}
