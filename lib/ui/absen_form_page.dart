import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/widgets/CustomTextButton.dart';
import 'package:absensi/widgets/RoundedButton.dart';
import 'package:absensi/widgets/RoundedTitleDropdown.dart';
import 'package:absensi/widgets/RoundedTitleInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:validatorless/validatorless.dart';
import 'package:absensi/models/tables/absen_model.dart';

class AbsenFormPage extends StatefulWidget {
  AbsenFormPage({
    super.key,
    this.absen,
  });
  AbsenModel? absen;

  @override
  State<AbsenFormPage> createState() => _AbsenFormPageState();
}

class _AbsenFormPageState extends State<AbsenFormPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  DateTime date = DateTime.now();
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

  List<String> tipe = [
    "masuk",
    "keluar",
  ];

  void _submit() {
    // if (!_formKey.currentState!.saveAndValidate()) {
    //   showSnackbar(context, "Semua kolom harus diisi!");
    // } else {
    //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     "/tab",
    //     (route) => false,
    //   );
    // }
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/tab",
      (route) => false,
    );
  }

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
          "${widget.absen == null ? 'Tambah' : 'Edit'} Absen",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: whiteColor,
                  ),
                  child: Column(
                    children: [
                      Column(
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
                      const SizedBox(height: 20),
                      RoundedTitleDropdown(
                        name: "karyawan",
                        type: "object",
                        items: dataKaryawan,
                        hintText: "Karyawan : ",
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 20),
                      RoundedTitleDropdown(
                        name: "tipe",
                        type: "string",
                        items: tipe,
                        hintText: "Absen : ",
                        onChanged: (val) {},
                      ),
                      const SizedBox(height: 40),
                      RoundedButton(
                        onPressed: _submit,
                        text: "Submit",
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
