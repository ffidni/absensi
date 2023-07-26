import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:validatorless/validatorless.dart';

class RoundedTitleInput extends StatelessWidget {
  RoundedTitleInput(
      {super.key,
      required this.title,
      required this.name,
      this.suffixIcon,
      this.readOnly = false,
      this.obscureText = false,
      this.validators,
      this.value,
      this.onChanged});

  final String title;
  final String name;
  final Icon? suffixIcon;
  final bool readOnly;
  final bool obscureText;
  String? value;
  List<String? Function(String?)>? validators;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackText.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 327,
          child: FormBuilderTextField(
            name: name,
            readOnly: readOnly,
            obscureText: obscureText,
            initialValue: value ?? "",
            onChanged: onChanged != null ? (e) => onChanged!(e ?? "") : null,
            validator:
                validators != null ? Validatorless.multiple(validators!) : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              filled: readOnly == true,
              fillColor: readOnly == true ? greyColor.withOpacity(0.2) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        )
      ],
    );
  }
}
