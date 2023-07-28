import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  EmptyData(
      {super.key, required this.title, required this.icon, this.center = true});

  final String title;
  final IconData icon;
  bool center;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: center ? MediaQuery.of(context).size.height / 2 : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 3),
          Text(
            title,
            style: blackText.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
