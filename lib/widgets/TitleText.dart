import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  TitleText({
    super.key,
    required this.text,
    this.icon,
  });

  final String text;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text,
              style: blackText.copyWith(fontSize: 16, fontWeight: semiBold),
            ),
            SizedBox(width: 3),
            if (icon != null) Icon(icon, size: 20)
          ],
        ),
        SizedBox(height: 9),
      ],
    );
  }
}
