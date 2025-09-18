import '../database/database_operations_service/database_operations_service.dart';
import '../models/orders_model.dart';

class OrderRepository {
  final DatabaseOperationsService databaseService;

  const OrderRepository(this.databaseService);

  Future<List> getAllOrders() {
    return databaseService.getAll();
  }

  Future getOrderById(int id) {
    return databaseService.getById(id);
  }

  Future<int> addOrder(OrdersModel order) {
    return databaseService.insert(order);
  }

  Future<int> updateOrder(OrdersModel order) {
    return databaseService.update(order);
  }

  Future<int> deleteOrder(int id) {
    return databaseService.delete(id);
  }
}
