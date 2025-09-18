import 'package:flutter/material.dart';

import '../../../core/constants/data/models/orders_model.dart';

class TodaySummaryReportWidget extends StatelessWidget {
  final List<OrdersModel> todayOrders;
  final int totalOrdersToday;
  final double totalRevenueToday;
  final int completedOrdersToday;
  final int pendingOrdersToday;

  const TodaySummaryReportWidget({
    super.key,
    required this.todayOrders,
    required this.totalOrdersToday,
    required this.totalRevenueToday,
    required this.completedOrdersToday,
    required this.pendingOrdersToday,
  });

  double get completionRate {
    if (totalOrdersToday == 0) return 0.0;
    return (completedOrdersToday / totalOrdersToday) * 100;
  }

  double get averageOrderValue {
    if (completedOrdersToday == 0) return 0.0;
    return totalRevenueToday / completedOrdersToday;
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ملخص الأداء اليومي',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 12),
        _buildSummaryRow('إجمالي الطلبات:', totalOrdersToday.toString()),
        _buildSummaryRow('الطلبات المكتملة:', completedOrdersToday.toString()),
        _buildSummaryRow('الطلبات المعلقة:', pendingOrdersToday.toString()),
        _buildSummaryRow('إجمالي الإيرادات:',
            '${totalRevenueToday.toStringAsFixed(2)} جنيه'),
        if (totalOrdersToday > 0) ...[
          const Divider(height: 20),
          _buildSummaryRow('متوسط قيمة الطلب:',
              '${averageOrderValue.toStringAsFixed(2)} جنيه'),
          _buildSummaryRow(
              'معدل الإكمال:', '${completionRate.toStringAsFixed(1)}%'),
        ],
      ],
    );
  }
}
