import 'package:absensi/blocs/absensi/absensi_bloc.dart';
import 'package:absensi/blocs/auth/auth_bloc.dart';
import 'package:absensi/models/page_fetchs/kehadiran_fetchs_model.dart';
import 'package:absensi/models/tables/absen_model.dart';
import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/absen_form_page.dart';
import 'package:absensi/ui/karyawan_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class KaryawanPage extends StatefulWidget {
  @override
  State<KaryawanPage> createState() => _KaryawanPageState();
}

class _KaryawanPageState extends State<KaryawanPage> {
  DateTime date = DateTime.now();
  List<int> selectedIds = [];

  List<UserModel> dataKaryawan = [
    UserModel(
      id: 1,
      email: "haikal@gmail.com",
      nama: "Haikal",
      tipeUser: "karyawan",
    ),
    UserModel(
      id: 2,
      email: "aldi@gmail.com",
      nama: "Aldi",
      tipeUser: "karyawan",
    ),
    UserModel(
      id: 3,
      email: "fitri@gmail.com",
      nama: "Fitri",
      tipeUser: "karyawan",
    ),
  ];

  void deleteUser() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 30, right: 8),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () => PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: KaryawanFormPage(),
          ),
          child: const Icon(Icons.add,
              color: Color.fromARGB(255, 62, 62, 62), size: 32),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Karyawan ${selectedIds.isEmpty ? '' : '(${selectedIds.length})'}",
          style: blackText.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
        actions: [
          if (selectedIds.isNotEmpty)
            Row(
              children: [
                IconButton(
                  iconSize: 28,
                  onPressed: deleteUser,
                  icon: Icon(
                    Icons.delete_outline,
                    color: blackColor,
                  ),
                ),
                IconButton(
                  iconSize: 28,
                  onPressed: () => setState(() {
                    selectedIds = [];
                  }),
                  icon: Icon(
                    Icons.cancel,
                    color: blackColor,
                  ),
                ),
              ],
            ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: dataKaryawan
                          .map(
                            (e) => buildKaryawanCard(e),
                          )
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void setSelectedKaryawan(int id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
  }

  void goToKaryawanForm({UserModel? user}) async {
    // PersistentNavBarNavigator.pushNewScreen(
    //   context,
    //   screen: ,
    //   pageTransitionAnimation: PageTransitionAnimation.sizeUp,
    // );
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KaryawanFormPage(user: user),
      ),
    );
  }

  Column buildKaryawanCard(UserModel e) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
          elevation: 2,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onLongPress: () => setSelectedKaryawan(e.id!),
            onTap: () => selectedIds.isNotEmpty
                ? setSelectedKaryawan(e.id!)
                : goToKaryawanForm(user: e),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selectedIds.contains(e.id)
                      ? blueColor
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_circle, size: 36),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Nama : ",
                                style: blackText.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${e.nama}",
                                style: blackText.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Email : ",
                            style: blackText.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "${e.email}",
                            style: blackText.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
