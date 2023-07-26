import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:validatorless/validatorless.dart';

class RoundedTitleDropdown extends StatelessWidget {
  RoundedTitleDropdown(
      {super.key,
      required this.name,
      required this.items,
      required this.hintText,
      required this.type,
      this.onChanged,
      this.value,
      this.validators});

  final List<dynamic> items;
  final String hintText;
  final String name;
  final String? value;
  final String type;
  List<String? Function(String?)>? validators;
  Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: name,
      initialValue: value ?? items[0],
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: hintText,
      ),
      onChanged: (item) => onChanged!(item!),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(hintText + (type == "string" ? e : e.name)),
            ),
          )
          .toList(),
    );
  }
}
