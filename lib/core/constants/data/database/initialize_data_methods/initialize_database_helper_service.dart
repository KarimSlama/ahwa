abstract class InitializeDatabaseHelperService {
  Future<void> initDatabase();
  Future<void> closeDatabase();
  Future<void> deleteDatabase();
}
