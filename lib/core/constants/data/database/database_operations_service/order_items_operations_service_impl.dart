import '../../models/order_items.dart';
import '../initialize_data_methods/local_database_helper.dart';
import 'database_operations_service.dart';

class OrderItemsDatabaseServiceImpl
    implements DatabaseOperationsService<OrderItems> {
  final LocalDatabaseHelper _dbHelper;

  OrderItemsDatabaseServiceImpl(this._dbHelper);

  @override
  Future<int> insert(OrderItems item) async {
    return await _dbHelper.database.insert('order_items', item.toJson());
  }

  @override
  Future<List<OrderItems>> getAll() async {
    final maps = await _dbHelper.database.query('order_items');
    return maps.map((e) => OrderItems.fromJson(e)).toList();
  }

  @override
  Future<OrderItems?> getById(int id) async {
    final maps = await _dbHelper.database.query(
      'order_items',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? OrderItems.fromJson(maps.first) : null;
  }

  @override
  Future<int> update(OrderItems item) async {
    return await _dbHelper.database.update(
      'order_items',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await _dbHelper.database.delete(
      'order_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<OrderItems>> getItemsByOrderId(int orderId) async {
    final maps = await _dbHelper.database.query(
      'order_items',
      where: 'order_id = ?',
      whereArgs: [orderId],
    );
    return maps.map((e) => OrderItems.fromJson(e)).toList();
  }
}
