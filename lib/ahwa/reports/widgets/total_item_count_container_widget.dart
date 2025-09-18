import 'package:flutter/material.dart';

import '../../../core/common/widget/circualr_containers/circular_container.dart';

class TotalItemCountContainerWidget extends StatelessWidget {
  final String title;
  final String totalText;
  final Color cardColor;
  const TotalItemCountContainerWidget({
    super.key,
    required this.title,
    required this.totalText,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CircularContainer(
        cardColor: cardColor,
        widget: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(totalText),
          ],
        ),
      ),
    );
  }
}
