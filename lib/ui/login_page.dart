import 'package:absensi/blocs/auth/auth_bloc.dart';
import 'package:absensi/models/forms/login_form_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/widgets/CustomTextButton.dart';
import 'package:absensi/widgets/RoundedButton.dart';
import 'package:absensi/widgets/RoundedTitleInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (!_formKey.currentState!.saveAndValidate()) {
      showSnackbar(context, "Semua kolom harus diisi!");
    } else {
      final loginForm = LoginFormModel(
        email: getFormText(_formKey, "email"),
        password: getFormText(_formKey, "password"),
      );
      context.read<AuthBloc>().add(AuthLogin(loginForm));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state);
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/tab", (route) => false);
          } else if (state is AuthFailed) {
            showSnackbar(context, state.error.message);
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Prilude Absensi",
                        style: blackText.copyWith(
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        "Login",
                        style: blackText.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 30),
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
                              title: "Email",
                              name: "email",
                              validators: [
                                Validatorless.required("Kolom ini harus diisi"),
                                Validatorless.email("Email tidak valid"),
                              ],
                            ),
                            const SizedBox(height: 20),
                            RoundedTitleInput(
                              title: "Password",
                              name: "password",
                              obscureText: true,
                              validators: [
                                Validatorless.required("Kolom ini harus diisi"),
                                Validatorless.min(6, "Minimal 6 karakter"),
                                Validatorless.max(20, "Maksimal 20 karakter"),
                              ],
                            ),
                            const SizedBox(height: 40),
                            RoundedButton(
                              onPressed: _submit,
                              text: "Login",
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextButton(
                        text: "Buat Akun",
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/register",
                          (route) => false,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
