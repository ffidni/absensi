import 'package:absensi/blocs/absensi/absensi_bloc.dart';
import 'package:absensi/blocs/auth/auth_bloc.dart';
import 'package:absensi/models/page_fetchs/kehadiran_fetchs_model.dart';
import 'package:absensi/models/tables/absen_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/absen_form_page.dart';
import 'package:absensi/widgets/EmptyData.dart';
import 'package:absensi/widgets/TitleText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class KehadiranPage extends StatefulWidget {
  @override
  State<KehadiranPage> createState() => _KehadiranPageState();
}

class _KehadiranPageState extends State<KehadiranPage> {
  DateTime date = DateTime.now();
  List<int> selectedIds = [];
  KehadiranFetchsModel? laporan;

  _selectDate(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      locale: LocaleType.id,
      minTime: DateTime(2022),
      maxTime: DateTime(2024),
      onConfirm: (time) {
        setState(() {
          date = time;
        });
        getAbsenData();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getLaporan();
  }

  void getLaporan() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context
          .read<AbsensiBloc>()
          .add(AbsensiGetLaporanKehadiran(authState.user.id!));
    }
  }

  void getAbsenData() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<AbsensiBloc>().add(
          AbsensiGetAllByDateAndUserId(authState.user.id!, date.toString()));
    }
  }

  Future<void> refreshData() async {
    getLaporan();
    getAbsenData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Laporan Kehadiran",
          style: blackText.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return BlocConsumer<AbsensiBloc, AbsensiState>(
              listener: (context, state) {
                if (state is AbsensiFailed) {
                  showSnackbar(context, state.error.message);
                }
              },
              builder: (context, state) {
                if (state is AbsensiGetLaporanSuccess) {
                  laporan = state.laporan;
                  print(laporan!.toJson());
                } else if (state is AbsensiGetAllSuccess) {
                  if (laporan != null) {
                    laporan!.absenData = state.absenData;
                  }
                }
                return SafeArea(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleText(text: "Laporan Bulan Ini"),
                                Wrap(
                                  spacing: 12,
                                  children: [
                                    buildCount(
                                        laporan?.hadirCountThisMonth
                                                ?.toString() ??
                                            "0",
                                        "Hadir",
                                        greenColor),
                                    buildCount(
                                        laporan?.izinCountThisMonth
                                                ?.toString() ??
                                            "0",
                                        "Izin",
                                        yellowColor),
                                    buildCount(
                                      laporan != null
                                          ? (getDayOfMonth() -
                                                  (laporan!
                                                          .hadirCountThisMonth! +
                                                      laporan!
                                                          .izinCountThisMonth!))
                                              .toString()
                                          : "0",
                                      "Absen",
                                      redErrorColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleText(text: "Laporan Minggu Ini"),
                                Wrap(
                                  spacing: 12,
                                  children: [
                                    buildCount(
                                        laporan?.hadirCountThisWeek
                                                ?.toString() ??
                                            "0",
                                        "Hadir",
                                        greenColor),
                                    buildCount(
                                        laporan?.izinCountThisWeek
                                                ?.toString() ??
                                            "0",
                                        "Izin",
                                        yellowColor),
                                    buildCount(
                                      laporan != null
                                          ? (6 -
                                                  (laporan!
                                                          .hadirCountThisWeek! +
                                                      laporan!
                                                          .izinCountThisWeek!))
                                              .toString()
                                          : "0",
                                      "Absen",
                                      redErrorColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleText(text: "Absen Hari Ini"),
                                const SizedBox(height: 5),
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
                                        const Icon(Icons.calendar_today,
                                            size: 26),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            if (laporan != null && laporan!.absenData != null)
                              laporan!.absenData!.isEmpty
                                  ? EmptyData(
                                      title: "Tidak ada absen pada tanggal ini",
                                      icon: Icons.not_interested_outlined,
                                      center: false,
                                    )
                                  : Column(
                                      children: laporan!.absenData!
                                          .map(
                                            (e) => buildAbsenCard(e),
                                          )
                                          .toList(),
                                    )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Container buildCount(String count, String name, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 90,
      height: 85,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: greyColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            count,
            style: blackText.copyWith(
              color: color,
              fontSize: 20,
              fontWeight: medium,
            ),
          ),
          Text(
            name,
            style: blackText.copyWith(
              fontSize: 13,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }

  Column buildAbsenCard(AbsenModel e) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 2,
          color: whiteColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
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
                        formatIndonesianDate(e.tanggal ?? DateTime.now()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        e.user?.nama ?? "",
                        style: blackText.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  if (e.status != null)
                    Row(
                      children: [
                        Text("Status : "),
                        Text(
                          "${e.status!} ${e.telatWaktu != null ? '(Telat ${convertMinutesToTimeFormat(e.telatWaktu!)})' : ''}",
                          style: blackText.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Text("Absen : "),
                      Text(
                        e.tipe ?? "",
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
