import 'package:ahwa/core/constants/data/models/order_items.dart';

import '../database/database_operations_service/database_operations_service.dart';

class OrderItemsRepository {
  final DatabaseOperationsService<OrderItems> _databaseService;

  OrderItemsRepository(this._databaseService);

  Future<List<OrderItems>> getAllOrderItems() => _databaseService.getAll();

  Future<OrderItems?> getOrderItemById(int id) => _databaseService.getById(id);

  Future<int> addOrderItem(OrderItems item) => _databaseService.insert(item);

  Future<int> updateOrderItem(OrderItems item) => _databaseService.update(item);

  Future<int> deleteOrderItem(int id) => _databaseService.delete(id);
}
