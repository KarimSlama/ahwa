import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    required this.widget,
    required this.cardColor,
    this.width = 0,
  });

  final Color cardColor;
  final Widget widget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsetsDirectional.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: cardColor,
      ),
      child: widget,
    );
  }
}
