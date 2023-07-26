import 'package:absensi/shared/theme.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.title,
  });

  VoidCallback onPressed;

  IconData icon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
        left: 30,
        right: 30,
      ),
      child: Material(
        color: greyBgColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: greyBgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  title,
                  style: blackText.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
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
