import 'package:absensi/blocs/auth/auth_bloc.dart';
import 'package:absensi/blocs/user/user_bloc.dart';
import 'package:absensi/models/forms/register_form_model.dart';
import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/widgets/CustomTextButton.dart';
import 'package:absensi/widgets/RoundedButton.dart';
import 'package:absensi/widgets/RoundedTitleInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:validatorless/validatorless.dart';

class KaryawanFormPage extends StatefulWidget {
  KaryawanFormPage({
    super.key,
    this.user,
  });
  UserModel? user;

  @override
  State<KaryawanFormPage> createState() => _KaryawanFormPageState();
}

class _KaryawanFormPageState extends State<KaryawanFormPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (!_formKey.currentState!.saveAndValidate()) {
      showSnackbar(context, "Semua kolom harus diisi!");
    } else {
      RegisterFormModel registerForm = RegisterFormModel(
        nama: getFormText(_formKey, "nama"),
        email: getFormText(_formKey, "email"),
        password: getFormText(_formKey, "password"),
      );
      context.read<UserBloc>().add(
            widget.user == null
                ? UserCreate(registerForm)
                : UpdateUserByAdmin(widget.user!.id!, registerForm),
          );
    }
  }

  void deleteUser() {
    print(widget.user!.id);
    context.read<UserBloc>().add(DeleteUser([widget.user!.id!]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.user == null ? 'Tambah' : 'Edit'} Karyawan",
        ),
        actions: widget.user == null
            ? null
            : [
                IconButton(
                  iconSize: 28,
                  onPressed: deleteUser,
                  icon: Icon(
                    Icons.delete_outline,
                    color: blackColor,
                  ),
                ),
              ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return BlocConsumer<UserBloc, UserState>(
            listener: (context, state) async {
              if (state is UserUpdateUserByAdminSuccess) {
                await showSnackbar(context, "Berhasil merubah data user",
                    isError: false);
                Navigator.pop(context);
              } else if (state is UserCreateSuccess) {
                await showSnackbar(context, "Berhasil menambah data user",
                    isError: false);
              } else if (state is UserDeleteUserSuccess) {
                await showSnackbar(context, "Berhasil menghapus data user",
                    isError: false);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
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
                              RoundedTitleInput(
                                title: "Nama Lengkap",
                                name: "nama",
                                value: widget.user?.nama ?? "",
                                validators: [
                                  Validatorless.required(
                                      "Kolom ini harus diisi"),
                                  Validatorless.min(2, "Minimal 2 karakter"),
                                  Validatorless.max(50, "Maksimal 50 karakter"),
                                ],
                              ),
                              const SizedBox(height: 20),
                              RoundedTitleInput(
                                title: "Email",
                                name: "email",
                                value: widget.user?.email ?? "",
                                validators: [
                                  Validatorless.required(
                                      "Kolom ini harus diisi"),
                                  Validatorless.email("Email tidak valid"),
                                ],
                              ),
                              const SizedBox(height: 20),
                              RoundedTitleInput(
                                title: "Password",
                                name: "password",
                                value: widget.user?.password ?? "",
                                validators: [
                                  Validatorless.required(
                                      "Kolom ini harus diisi"),
                                  Validatorless.min(6, "Minimal 6 karakter"),
                                  Validatorless.max(20, "Maksimal 20 karakter"),
                                ],
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
              );
            },
          );
        },
      ),
    );
  }
}
