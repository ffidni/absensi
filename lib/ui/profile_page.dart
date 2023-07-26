import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/profile_form_page.dart';
import 'package:absensi/widgets/ProfileButton.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user = UserModel(
    email: "haikal@gmail.com",
    name: "Muhammad Haikal",
  );

  void logout() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 40,
            ),
            child: Column(
              children: [
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 80,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          user!.name!,
                          style: blackText.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 30),
                        ProfileButton(
                          onPressed: () =>
                              PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: ProfileFormPage(),
                          ),
                          icon: Icons.edit,
                          title: "Edit Profile",
                        ),
                        ProfileButton(
                          onPressed: logout,
                          icon: Icons.logout,
                          title: "Logout",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
