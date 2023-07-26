import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 3),
          Text("Belum ada $title", style: blackText.copyWith(fontSize: 20)),
        ],
      ),
    );
  }
}
