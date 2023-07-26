import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final VoidCallback onPressed;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: greyText.copyWith(
            fontSize: 16,
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
