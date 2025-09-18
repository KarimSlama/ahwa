import 'package:ahwa/core/constants/data/database/initialize_data_methods/local_database_helper.dart';

import '../../models/orders_model.dart';
import '../database_operations_service/orders_operations_service_impl.dart';
import 'reports_service.dart';

class ReportServiceImpl implements ReportService {
  final OrdersDatabaseServiceImpl _ordersService;

  ReportServiceImpl(this._ordersService);

  @override
  Future<Map<String, int>> getTopSellingDrinks() async {
    final db = LocalDatabaseHelper().database;
    final result = await db.rawQuery('''
      SELECT drink_name, SUM(quantity) as total_quantity
      FROM order_items oi
      JOIN orders o ON oi.order_id = o.id
      WHERE DATE(o.created_at) = DATE('now', 'localtime')
      GROUP BY drink_name
      ORDER BY total_quantity DESC
      LIMIT 5
    ''');

    return Map<String, int>.fromEntries(
      result.map((row) => MapEntry(
            row['drink_name'] as String,
            row['total_quantity'] as int,
          )),
    );
  }

  @override
  Future<int> getTotalOrdersToday() async {
    final todayOrders = await _ordersService.getTodayOrders();
    return todayOrders.length;
  }

  @override
  Future<double> getTodayRevenue() async {
    final todayOrders = await _ordersService.getTodayOrders();
    double totalRevenue = 0.0;
    for (var order in todayOrders) {
      if (order.isCompleted) {
        totalRevenue += order.total;
      }
    }
    return totalRevenue;
  }

  @override
  Future<List<OrdersModel>> getTodayOrders() async {
    return await _ordersService.getTodayOrders();
  }
}
