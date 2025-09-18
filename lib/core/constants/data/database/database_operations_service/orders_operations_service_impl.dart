import '../../models/orders_model.dart';
import '../initialize_data_methods/local_database_helper.dart';
import 'database_operations_service.dart';

class OrdersDatabaseServiceImpl
    implements DatabaseOperationsService<OrdersModel> {
  final LocalDatabaseHelper _dbHelper;

  OrdersDatabaseServiceImpl(this._dbHelper);

  @override
  Future<int> insert(OrdersModel item) async {
    return await _dbHelper.database.insert('orders', item.toJson());
  }

  @override
  Future<List<OrdersModel>> getAll() async {
    final maps = await _dbHelper.database.query(
      'orders',
      orderBy: 'created_at DESC',
    );
    return maps.map((e) => OrdersModel.fromJson(e)).toList();
  }

  @override
  Future<OrdersModel?> getById(int id) async {
    final maps = await _dbHelper.database.query(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? OrdersModel.fromJson(maps.first) : null;
  }

  @override
  Future<int> update(OrdersModel item) async {
    return await _dbHelper.database.update(
      'orders',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await _dbHelper.database.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<OrdersModel>> getPendingOrders() async {
    final maps = await _dbHelper.database.query(
      'orders',
      where: 'status = ?',
      whereArgs: ['pending'],
      orderBy: 'created_at ASC',
    );
    return maps.map((e) => OrdersModel.fromJson(e)).toList();
  }

  Future<List<OrdersModel>> getTodayOrders() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final maps = await _dbHelper.database.query(
      'orders',
      where: 'created_at >= ? AND created_at < ?',
      whereArgs: [startOfDay.toIso8601String(), endOfDay.toIso8601String()],
    );
    return maps.map((e) => OrdersModel.fromJson(e)).toList();
  }
}
