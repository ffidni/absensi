import 'package:absensi/blocs/auth/auth_bloc.dart';
import 'package:absensi/blocs/user/user_bloc.dart';
import 'package:absensi/models/forms/login_form_model.dart';
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

class ProfileFormPage extends StatefulWidget {
  ProfileFormPage({
    super.key,
  });

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  UserModel? user;

  void _submit() {
    if (!_formKey.currentState!.saveAndValidate()) {
      showSnackbar(context, "Semua kolom harus diisi!");
    } else {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthSuccess) {
        final RegisterFormModel data = RegisterFormModel(
          nama: getFormText(_formKey, "nama"),
          email: getFormText(_formKey, "email"),
          password: getFormText(_formKey, "password"),
        );
        print(data.toJson());
        context.read<UserBloc>().add(UpdateUser(authState.user.id!, data));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, aState) {
          if (aState is AuthSuccess) {
            user = aState.user;
          }
          return BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (aState is AuthSuccess) {
                if (state is UserUpdateUserSuccess) {
                  showSnackbar(
                    context,
                    "Berhasil merubah data user!",
                    isError: false,
                  );
                  final UserModel newUser = aState.user.copyWith(
                    email: state.user.email,
                    nama: state.user.nama,
                    password: state.user.password,
                  );
                  context.read<AuthBloc>().add(
                        AuthLogin(
                          LoginFormModel(
                            email: newUser.email,
                            password: getFormText(_formKey, "password"),
                          ),
                        ),
                      );
                } else if (state is UserFailed) {
                  showSnackbar(context, state.error.message);
                }
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
                                value: user?.nama ?? "",
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
                                value: user?.email ?? "",
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
                                value: user?.password ?? "",
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
