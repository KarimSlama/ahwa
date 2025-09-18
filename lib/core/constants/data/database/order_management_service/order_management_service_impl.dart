import '../../models/order_items.dart';
import '../../models/orders_model.dart';
import '../database_operations_service/order_items_operations_service_impl.dart';
import '../database_operations_service/orders_operations_service_impl.dart';
import 'order_management_service.dart';

class OrderManagementServiceImpl implements OrderManagementService {
  final OrdersDatabaseServiceImpl _ordersService;
  final OrderItemsDatabaseServiceImpl _orderItemsService;

  OrderManagementServiceImpl(this._ordersService, this._orderItemsService);

  @override
  Future<int> createOrder(OrdersModel order, List<OrderItems> items) async {
    final orderId = await _ordersService.insert(order);

    for (var item in items) {
      final updatedItem = OrderItems(
        orderId: orderId,
        drinkId: item.drinkId,
        drinkName: item.drinkName,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        notes: item.notes,
      );
      await _orderItemsService.insert(updatedItem);
    }

    return orderId;
  }

  @override
  Future<bool> completeOrder(int orderId) async {
    final order = await _ordersService.getById(orderId);
    if (order == null) return false;

    final completedOrder = order.copyWith(
      status: OrderStatus.completed,
      completedAt: DateTime.now(),
    );

    final result = await _ordersService.update(completedOrder);
    return result > 0;
  }

  @override
  Future<List<OrdersModel>> getPendingOrders() async {
    return await _ordersService.getPendingOrders();
  }

  @override
  Future<List<OrdersModel>> getCompletedOrders() async {
    final allOrders = await _ordersService.getAll();
    return allOrders.where((order) => order.isCompleted).toList();
  }
}
