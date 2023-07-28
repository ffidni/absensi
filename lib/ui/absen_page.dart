import 'package:absensi/widgets/EmptyData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:absensi/blocs/absensi/absensi_bloc.dart';
import 'package:absensi/blocs/auth/auth_bloc.dart';
import 'package:absensi/models/tables/absen_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/ui/absen_form_page.dart';

class AbsenPage extends StatefulWidget {
  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  DateTime date = DateTime.now();
  List<int> selectedIds = [];

  List<AbsenModel> absenData = [];

  _selectDate(BuildContext dialogContext) {
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

  Future<void> getAbsenData() async {
    context.read<AbsensiBloc>().add(AbsensiGetAllByDate(date.toString()));
    resetSelected();
  }

  void deleteAbsen() {
    context.read<AbsensiBloc>().add(AbsensiDelete(selectedIds));
  }

  void setSelectedAbsen(int id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
  }

  void goToAbsenForm({AbsenModel? absen}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AbsenFormPage(absen: absen),
      ),
    );
    refreshPage();
  }

  void resetSelected() {
    setState(() {
      selectedIds = [];
    });
  }

  @override
  void initState() {
    super.initState();
    getAbsenData();
  }

  Future<void> refreshPage() async {
    getAbsenData();
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
            screen: AbsenFormPage(),
          ),
          child: const Icon(Icons.add,
              color: Color.fromARGB(255, 62, 62, 62), size: 32),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Absen ${selectedIds.isEmpty ? '' : '(${selectedIds.length})'}",
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
                  onPressed: deleteAbsen,
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
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return BlocConsumer<AbsensiBloc, AbsensiState>(
              listener: (context, state) {
                if (state is AbsensiFailed) {
                  showSnackbar(context, state.error.message);
                } else if (state is AbsensiSuccess) {
                  showSnackbar(context, state.message, isError: false);
                  getAbsenData();
                }
              },
              builder: (context, state) {
                if (state is AbsensiGetAllSuccess) {
                  absenData = state.absenData;
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
                                          const Icon(Icons.calendar_today,
                                              size: 26),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            state is AbsensiLoading
                                ? Center(child: CircularProgressIndicator())
                                : absenData.isEmpty
                                    ? EmptyData(
                                        title:
                                            "Tidak ada absen pada tanggal ini",
                                        icon: Icons.not_interested_outlined,
                                      )
                                    : Column(
                                        children: absenData
                                            .map((e) => buildAbsenCard(e))
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

  Column buildAbsenCard(AbsenModel e) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 2,
          color: whiteColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onLongPress: () => setSelectedAbsen(e.id!),
            onTap: () => selectedIds.isNotEmpty
                ? setSelectedAbsen(e.id!)
                : goToAbsenForm(absen: e),
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
                        formatIndonesianDate(e.tanggal ??
                            DateTime
                                .now()), // Use null-aware operator (??) to handle null values
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        e.user?.nama ??
                            '', // Use null-aware operator (??) to handle null values
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
                        e.tipe ??
                            '', // Use null-aware operator (??) to handle null values
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
