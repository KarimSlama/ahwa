import 'package:flutter/material.dart';

import '../../../core/common/widget/circualr_containers/circular_container.dart';
import '../../../core/common/widget/divider/horizontal_divider.dart';

class TopSellingItem extends StatelessWidget {
  const TopSellingItem({
    super.key,
    required this.drinkName,
    required this.percentage,
    required this.quantity,
  });

  final String drinkName;
  final double percentage;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CircularContainer(
        cardColor: Colors.deepOrange.shade100,
        width: double.infinity,
        widget: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  drinkName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const HorizontalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  '(${percentage.toStringAsFixed(1)}%)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepOrange.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const HorizontalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  '$quantity طلب',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const HorizontalDivider(),
              Expanded(
                flex: 2,
                child: Text(
                  '${(quantity * 10).toStringAsFixed(0)} ج.م',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
