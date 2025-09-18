import 'package:flutter/material.dart';

class IconWithTextInRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isStatus;
  const IconWithTextInRow(
      {super.key,
      required this.icon,
      required this.text,
      this.isStatus = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        Text(text),
      ],
    );
  }
}
