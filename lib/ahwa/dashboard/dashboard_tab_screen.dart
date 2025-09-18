import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/common/widget/circualr_containers/circular_container_shadow.dart';
import '../../core/constants/data/database/database_operations_service/orders_operations_service_impl.dart';
import '../../core/constants/data/database/initialize_data_methods/local_database_helper.dart';
import '../../core/constants/data/models/orders_model.dart';
import '../../core/constants/data/repository/order_repository.dart';
import 'widget/icon_with_text_in_row.dart';

class DashboardTabScreen extends StatefulWidget {
  const DashboardTabScreen({super.key});

  @override
  State<DashboardTabScreen> createState() => _DashboardTabScreenState();
}

class _DashboardTabScreenState extends State<DashboardTabScreen> {
  List<OrdersModel> orders = [];
  bool isLoading = true;
  late OrderRepository orderRepository;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      await LocalDatabaseHelper().initDatabase();
      orderRepository =
          OrderRepository(OrdersDatabaseServiceImpl(LocalDatabaseHelper()));

      final loadedOrders = await orderRepository.getAllOrders();
      setState(() {
        orders = List<OrdersModel>.from(loadedOrders);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await _initData();
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'في الانتظار';
      case OrderStatus.completed:
        return 'مكتمل';
      case OrderStatus.cancelled:
        return 'ملغي';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.bag_cross_1_copy,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد طلبات حتى الآن',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'اضغط على + لإضافة طلب جديد',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _refreshData,
              icon: const Icon(Iconsax.refresh),
              label: const Text('تحديث'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, index) => const SizedBox(height: 16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return CircularContainerShadow(
            radius: 12,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconWithTextInRow(
                  icon: Iconsax.profile_2user,
                  text: 'اسم الزبون: ${order.customerName}',
                ),
                const SizedBox(height: 12),
                IconWithTextInRow(
                  icon: Iconsax.tag_copy,
                  text: 'رقم الطلب: #${order.orderId}',
                ),
                const SizedBox(height: 12),
                IconWithTextInRow(
                  icon: Iconsax.calendar,
                  text: 'تاريخ الطلب: ${_formatDate(order.createdAt)}',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Iconsax.archive_2_copy,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'حالة الطلب: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _getStatusColor(order.status).withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _getStatusColor(order.status),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _getStatusText(order.status),
                        style: TextStyle(
                          fontSize: 12,
                          color: _getStatusColor(order.status),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                IconWithTextInRow(
                  icon: Iconsax.activity_copy,
                  text: 'إجمالي السعر: ${order.total.toStringAsFixed(2)} جنيه',
                ),
                if (order.notes.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  IconWithTextInRow(
                    icon: Iconsax.note_1_copy,
                    text: 'ملاحظات: ${order.notes}',
                  ),
                ],
                if (order.completedAt != null) ...[
                  const SizedBox(height: 12),
                  IconWithTextInRow(
                    icon: Iconsax.tick_circle_copy,
                    text: 'تم الإكمال: ${_formatDate(order.completedAt!)}',
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
