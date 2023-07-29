import 'package:absensi/blocs/absensi/absensi_bloc.dart';
import 'package:absensi/blocs/auth/auth_bloc.dart';
import 'package:absensi/blocs/user/user_bloc.dart';
import 'package:absensi/models/forms/absen_form_model.dart';
import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/widgets/CustomTextButton.dart';
import 'package:absensi/widgets/RoundedButton.dart';
import 'package:absensi/widgets/RoundedTitleDropdown.dart';
import 'package:absensi/widgets/RoundedTitleInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<UserModel> dataKaryawan = [];

  List<String> tipe = [
    "masuk",
    "keluar",
  ];

  List<String> status = [
    "Hadir",
    "Izin",
  ];

  void _submit() {
    dynamic karyawanInput = getFormText(_formKey, "karyawan", toString: false);
    String tipe = getFormText(_formKey, "tipe");
    String status = getFormText(_formKey, "status");

    if (karyawanInput == null || tipe == "" || status == "") {
      showSnackbar(context, "Semua kolom harus diisi!");
    } else {
      UserModel karyawan = karyawanInput;
      final AbsenFormModel absenForm = AbsenFormModel(
          tipe: tipe,
          userId: karyawan.id.toString(),
          status: status,
          tanggal: date.toString());
      print(absenForm.toJson());
      context.read<AbsensiBloc>().add(
            widget.absen == null
                ? AbsensiAdd(absenForm)
                : AbsensiEdit(widget.absen!.id!, absenForm),
          );
    }
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

  void deleteAbsen() {
    context.read<AbsensiBloc>().add(AbsensiDelete([widget.absen!.id!]));
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<UserBloc>().add(GetAllKaryawan());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.absen == null ? 'Tambah' : 'Edit'} Absen",
          ),
          actions: widget.absen == null
              ? null
              : [
                  IconButton(
                    iconSize: 28,
                    onPressed: deleteAbsen,
                    icon: Icon(
                      Icons.delete_outline,
                      color: blackColor,
                    ),
                  ),
                ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return BlocConsumer<AbsensiBloc, AbsensiState>(
              listener: (context, state) async {
                print(state);
                if (state is AbsensiSuccess) {
                  await showSnackbar(context, state.message, isError: false);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserFailed) {
                      showSnackbar(context, state.error.message);
                    } else if (state is UserUpdateUserByAdminSuccess) {
                      showSnackbar(context, "Berhasil merubah data user",
                          isError: false);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserGetKaryawanSuccess) {
                      dataKaryawan = state.karyawan;
                    }
                    return state is UserGetKaryawanSuccess
                        ? SingleChildScrollView(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                onTap: () =>
                                                    _selectDate(context),
                                                child: Container(
                                                  padding: EdgeInsets.all(12),
                                                  width: 327,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    border: Border.all(
                                                      width: 2,
                                                      color: greyColor,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        formatIndonesianDate(
                                                            date),
                                                      ),
                                                      Spacer(),
                                                      const Icon(
                                                          Icons.calendar_today,
                                                          size: 26),
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
                                            value: widget.absen?.user,
                                            items: dataKaryawan,
                                            hintText: "Karyawan : ",
                                            onChanged: (val) {},
                                          ),
                                          const SizedBox(height: 20),
                                          RoundedTitleDropdown(
                                            name: "status",
                                            type: "string",
                                            value: widget.absen?.status,
                                            items: status,
                                            hintText: "Status : ",
                                            onChanged: (val) {},
                                          ),
                                          const SizedBox(height: 20),
                                          RoundedTitleDropdown(
                                            name: "tipe",
                                            type: "string",
                                            value: widget.absen?.tipe,
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
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                );
              },
            );
          },
        ));
  }
}
