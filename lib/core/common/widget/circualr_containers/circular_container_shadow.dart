import 'package:flutter/material.dart';

class CircularContainerShadow extends StatelessWidget {
  final Widget widget;
  final double radius;
  final Color? color;

  const CircularContainerShadow({
    super.key,
    required this.widget,
    this.radius = 100,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(radius),
        boxShadow: [
          BoxShadow(
            color: color ?? Colors.grey.withValues(alpha: .1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: widget,
    );
  }
}
