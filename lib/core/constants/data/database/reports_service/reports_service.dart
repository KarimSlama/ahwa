import '../../models/orders_model.dart';

abstract class ReportService {
  Future<Map<String, int>> getTopSellingDrinks();
  Future<int> getTotalOrdersToday();
  Future<double> getTodayRevenue();
  Future<List<OrdersModel>> getTodayOrders();
}
