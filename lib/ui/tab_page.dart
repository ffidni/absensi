import 'package:absensi/blocs/auth/auth_bloc.dart';
import 'package:absensi/shared/shared_values.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/absen_page.dart';
import 'package:absensi/ui/karyawan_page.dart';
import 'package:absensi/ui/kehadiran_page.dart';
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

  List<PersistentBottomNavBarItem> _buildNavItems(AuthState state) {
    if (state is AuthSuccess) {
      List<PersistentBottomNavBarItem> result = [];
      for (var navigation in navigationList) {
        print(result);
        if (navigation['tipe_user'] == state.user.tipeUser ||
            navigation['tipe_user'] == "all") {
          result.add(
            PersistentBottomNavBarItem(
              icon: navigation['icon'],
              title: navigation['label'],
              activeColorPrimary: yellowColor,
              inactiveColorPrimary: greyColor,
            ),
          );
        }
      }
      return result;
    }
    return [];
  }

  List<Widget> _buildScreens(AuthState state) {
    if (state is AuthSuccess) {
      if (state.user.tipeUser == "admin") {
        return [AbsenPage(), KaryawanPage(), ProfilePage()];
      }
      return [KehadiranPage(), ProfilePage()];
    }
    return [];
  }

  final GlobalKey<ScaffoldState> _tabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
            key: _tabKey,
            body: state is AuthSuccess
                ? PersistentTabView(
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
                    screens: _buildScreens(state),
                    items: _buildNavItems(state),
                    navBarStyle: NavBarStyle.style3,
                  )
                : Container(
                    color: greyBgColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          const SizedBox(height: 8),
                          Text(
                            "Mengubah data",
                            style: blackText.copyWith(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
