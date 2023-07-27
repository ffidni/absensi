import 'package:absensi/models/tables/user_model.dart';
import 'package:absensi/shared/shared_methods.dart';
import 'package:absensi/shared/theme.dart';
import 'package:absensi/widgets/CustomTextButton.dart';
import 'package:absensi/widgets/RoundedButton.dart';
import 'package:absensi/widgets/RoundedTitleInput.dart';
import 'package:flutter/material.dart';
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.user == null ? 'Tambah' : 'Edit'} Karyawan",
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
                      RoundedTitleInput(
                        title: "Nama Lengkap",
                        name: "Nama Lengkap",
                        value: widget.user?.nama ?? "",
                        validators: [
                          Validatorless.required("Kolom ini harus diisi"),
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
                          Validatorless.required("Kolom ini harus diisi"),
                          Validatorless.email("Email tidak valid"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      RoundedTitleInput(
                        title: "Password",
                        name: "password",
                        value: widget.user?.password ?? "",
                        validators: [
                          Validatorless.required("Kolom ini harus diisi"),
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
      ),
    );
  }
}
