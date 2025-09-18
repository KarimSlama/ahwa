import 'package:ahwa/ahwa/reports/widgets/today_summary_report_widget.dart';
import 'package:flutter/material.dart';

import '../../core/common/widget/heading/section_heading.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/data/database/database_operations_service/orders_operations_service_impl.dart';
import '../../core/constants/data/database/initialize_data_methods/local_database_helper.dart';
import '../../core/constants/data/models/orders_model.dart';
import '../../core/constants/data/repository/order_repository.dart';
import '../../core/span_text.dart';
import 'widgets/no_top_selling_item_enter_new_orders.dart';
import 'widgets/top_selling_item.dart';
import 'widgets/total_item_count_container_widget.dart';

class ReportsTabScreen extends StatefulWidget {
  const ReportsTabScreen({super.key});

  @override
  State<ReportsTabScreen> createState() => _ReportsTabScreenState();
}

class _ReportsTabScreenState extends State<ReportsTabScreen> {
  List<OrdersModel> todayOrders = [];
  List<OrdersModel> allOrders = [];
  bool isLoading = true;
  late OrderRepository orderRepository;

  int totalOrdersToday = 0;
  double totalRevenueToday = 0.0;
  int completedOrdersToday = 0;
  int pendingOrdersToday = 0;
  Map<String, int> topSellingDrinks = {};

  @override
  void initState() {
    super.initState();
    _loadReportsData();
  }

  Future<void> _loadReportsData() async {
    setState(() {
      isLoading = true;
    });

    await LocalDatabaseHelper().initDatabase();
    orderRepository =
        OrderRepository(OrdersDatabaseServiceImpl(LocalDatabaseHelper()));

    final loadedOrders = await orderRepository.getAllOrders();

    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final todayOrdersList = loadedOrders.where((order) {
      return order.createdAt.isAfter(startOfDay) &&
          order.createdAt.isBefore(endOfDay);
    }).toList();

    _calculateStatistics(
      List<OrdersModel>.from(todayOrdersList),
      List<OrdersModel>.from(loadedOrders),
    );

    setState(() {
      todayOrders = List<OrdersModel>.from(todayOrdersList);
      allOrders = List<OrdersModel>.from(loadedOrders);
      isLoading = false;
    });
  }

  void _calculateStatistics(
      List<OrdersModel> todayOrders, List<OrdersModel> allOrders) {
    totalOrdersToday = todayOrders.length;

    completedOrdersToday = todayOrders
        .where((order) => order.status == OrderStatus.completed)
        .length;
    pendingOrdersToday = todayOrders
        .where((order) => order.status == OrderStatus.pending)
        .length;

    totalRevenueToday = 0.0;
    for (var order in todayOrders) {
      if (order.status == OrderStatus.completed) {
        totalRevenueToday += order.total;
      }
    }

    Map<String, int> drinkCounts = {};

    for (var order in todayOrders) {
      if (order.status == OrderStatus.completed) {
        String drinkName = _extractDrinkNameFromOrder(order);
        drinkCounts[drinkName] = (drinkCounts[drinkName] ?? 0) + 1;
      }
    }

    var sortedDrinks = drinkCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    topSellingDrinks = Map.fromEntries(sortedDrinks.take(5));
  }

  String _extractDrinkNameFromOrder(OrdersModel order) {
    if (order.notes.isNotEmpty) {
      return order.notes;
    }
    return 'مشروب غير محدد';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  double _calculateDrinkPercentage(String drinkName) {
    if (completedOrdersToday == 0) return 0.0;
    int drinkCount = topSellingDrinks[drinkName] ?? 0;
    return (drinkCount / completedOrdersToday) * 100;
  }

  Future<void> _refreshData() async {
    await _loadReportsData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpanText(
              text: AppStrings.reportFor,
              actionText: _formatDate(DateTime.now()),
              actionTextOnTap: () {},
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TotalItemCountContainerWidget(
                    cardColor: Colors.orange.withValues(alpha: 0.3),
                    title: 'إجمالي الطلبات',
                    totalText: totalOrdersToday.toString(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TotalItemCountContainerWidget(
                    cardColor: Colors.green.withValues(alpha: 0.3),
                    title: 'إجمالي الإيرادات',
                    totalText: '${totalRevenueToday.toStringAsFixed(0)} ج.م',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (totalOrdersToday > 0) ...[
              Row(
                children: [
                  Expanded(
                    child: TotalItemCountContainerWidget(
                      cardColor: Colors.blue.withValues(alpha: .3),
                      title: 'الطلبات المكتملة',
                      totalText: completedOrdersToday.toString(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TotalItemCountContainerWidget(
                      cardColor: Colors.purple.withValues(alpha: 0.3),
                      title: 'الطلبات المعلقة',
                      totalText: pendingOrdersToday.toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            const SectionHeading(title: AppStrings.topSelling),
            const SizedBox(height: 12),
            if (topSellingDrinks.isEmpty)
              NoTopSellingItemEnterNewOrders()
            else
              ...topSellingDrinks.entries.map((entry) {
                String drinkName = entry.key;
                int quantity = entry.value;
                double percentage = _calculateDrinkPercentage(drinkName);

                return TopSellingItem(
                  drinkName: drinkName,
                  percentage: percentage,
                  quantity: quantity,
                );
              }),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: TodaySummaryReportWidget(
                todayOrders: todayOrders,
                totalOrdersToday: totalOrdersToday,
                totalRevenueToday: totalRevenueToday,
                completedOrdersToday: completedOrdersToday,
                pendingOrdersToday: pendingOrdersToday,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
