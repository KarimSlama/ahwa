import '../../models/order_items.dart';
import '../../models/orders_model.dart';

abstract class OrderManagementService {
  Future<int> createOrder(OrdersModel order, List<OrderItems> items);
  Future<bool> completeOrder(int orderId);
  Future<List<OrdersModel>> getPendingOrders();
  Future<List<OrdersModel>> getCompletedOrders();
}
