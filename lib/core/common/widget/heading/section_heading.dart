import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  const SectionHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w600, fontSize: 18));
  }
}
