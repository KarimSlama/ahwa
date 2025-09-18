import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/constants/data/models/orders_model.dart';

class ActionButtonsForOrder extends StatelessWidget {
  final OrdersModel order;
  final Future<void> Function(OrdersModel order)? onComplete;
  final void Function(OrdersModel order)? onViewDetails;

  const ActionButtonsForOrder({
    super.key,
    required this.order,
    this.onComplete,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (order.status == OrderStatus.pending)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onComplete == null
                  ? null
                  : () async {
                      await onComplete!(order);
                    },
              icon: const Icon(Iconsax.tick_circle_copy, size: 16),
              label: const Text('تأكيد الطلب'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        if (order.status == OrderStatus.pending) const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              if (onViewDetails != null) {
                onViewDetails!(order);
                return;
              }
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('تفاصيل الطلب #${order.orderId}'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('الزبون: ${order.customerName}'),
                      Text('السعر: ${order.total} جنيه'),
                      Text('التاريخ: ${_formatDate(order.createdAt)}'),
                      Text('الحالة: ${_getStatusText(order.status)}'),
                      if (order.notes.isNotEmpty == true)
                        Text('ملاحظات: ${order.notes}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إغلاق'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Iconsax.eye_copy, size: 16),
            label: const Text('التفاصيل'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
              side: const BorderSide(color: Colors.blue),
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dateTime) {
    final local = dateTime.toLocal();
    two(int n) => n.toString().padLeft(2, '0');
    return '${local.year}-${two(local.month)}-${two(local.day)} ${two(local.hour)}:${two(local.minute)}';
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.completed:
        return 'مكتمل';
      case OrderStatus.cancelled:
        return 'ملغي';
    }
  }
}
