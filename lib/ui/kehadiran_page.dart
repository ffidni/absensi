import 'package:absensi/models/tables/absen_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/absen_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class KehadiranPage extends StatefulWidget {
  @override
  State<KehadiranPage> createState() => _KehadiranPageState();
}

class _KehadiranPageState extends State<KehadiranPage> {
  DateTime date = DateTime.now();
  List<int> selectedIds = [];

  List<AbsenModel> absenData = [
    AbsenModel(
      id: 1,
      tipe: "masuk",
      nama: "Haikal",
      tanggal: DateTime.now(),
      userId: 1,
    ),
    AbsenModel(
      id: 2,
      tipe: "keluar",
      nama: "Aldi",
      tanggal: DateTime.now(),
      userId: 2,
    ),
    AbsenModel(
      id: 3,
      tipe: "masuk",
      nama: "Fitri",
      tanggal: DateTime.now(),
      userId: 3,
    ),
  ];

  _selectDate(BuildContext dialogContext) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      locale: LocaleType.id,
      minTime: DateTime(2022),
      maxTime: DateTime(2024),
      onConfirm: (time) {
        setState(() {
          date = time;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kehadiran",
          style: blackText.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tanggal",
                        style: blackText.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          width: 327,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: whiteColor,
                            border: Border.all(
                              width: 2,
                              color: greyColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                formatIndonesianDate(date),
                              ),
                              Spacer(),
                              const Icon(Icons.calendar_today, size: 26),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: absenData
                      .map(
                        (e) => buildKehadiranCard(e),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildKehadiranCard(AbsenModel e) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 2,
          color: whiteColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        formatIndonesianDate(e.tanggal!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        e.nama!,
                        style: blackText.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Absen : "),
                      Text(
                        e.tipe!.toUpperCase(),
                        style: blackText.copyWith(
                          fontSize: 16,
                        ),
                      ),
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
