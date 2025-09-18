import '../database/database_operations_service/database_operations_service.dart';
import '../models/drinks_model.dart';

class DrinksRepository {
  final DatabaseOperationsService<DrinksModel> _databaseService;

  DrinksRepository(this._databaseService);

  Future<List<DrinksModel>> getAllDrinks() => _databaseService.getAll();
  Future<DrinksModel?> getDrinkById(int id) => _databaseService.getById(id);
  Future<int> addDrink(DrinksModel drink) => _databaseService.insert(drink);
  Future<int> updateDrink(DrinksModel drink) => _databaseService.update(drink);
  Future<int> deleteDrink(int id) => _databaseService.delete(id);
}
