import '../../models/drinks_model.dart';
import '../initialize_data_methods/local_database_helper.dart';
import 'database_operations_service.dart';

class DrinksDatabaseServiceImpl
    implements DatabaseOperationsService<DrinksModel> {
  final LocalDatabaseHelper _dbHelper;

  DrinksDatabaseServiceImpl(this._dbHelper);

  @override
  Future<int> insert(DrinksModel item) async {
    return await _dbHelper.database.insert('drinks', item.toJson());
  }

  @override
  Future<List<DrinksModel>> getAll() async {
    final maps =
        await _dbHelper.database.query('drinks', where: 'is_available = 1');
    return maps.map((e) => DrinksModel.fromJson(e)).toList();
  }

  @override
  Future<DrinksModel?> getById(int id) async {
    final maps = await _dbHelper.database.query(
      'drinks',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? DrinksModel.fromJson(maps.first) : null;
  }

  @override
  Future<int> update(DrinksModel item) async {
    return await _dbHelper.database.update(
      'drinks',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await _dbHelper.database.update(
      'drinks',
      {'is_available': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
