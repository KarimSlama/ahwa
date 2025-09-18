import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .4,
      height: 24,
      color: Colors.black12.withValues(alpha: .8),
    );
  }
}
