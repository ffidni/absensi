import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.onPressed,
      this.width = double.infinity,
      this.height = 50,
      required this.text});

  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(56),
          ),
          backgroundColor: yellowColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: whiteText.copyWith(fontSize: 16, fontWeight: semiBold),
        ),
      ),
    );
  }
}
