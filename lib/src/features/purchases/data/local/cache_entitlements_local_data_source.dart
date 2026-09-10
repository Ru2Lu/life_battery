import 'package:life_battery/src/database/local_database.dart';
import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';
import 'package:sqflite/sqflite.dart';

class CacheEntitlementsLocalDataSource implements EntitlementsLocalDataSource {
  const CacheEntitlementsLocalDataSource({
    required LocalDatabase localDatabase,
  }) : _localDatabase = localDatabase;

  final LocalDatabase _localDatabase;

  static const _tableName = 'lifespan';
  static const _columnHasPremiumLifetime = 'hasPremiumLifetime';

  @override
  Future<bool> getIsPremium() async {
    try {
      final db = await _localDatabase.database;
      final result = await db.query(
        _tableName,
        columns: [_columnHasPremiumLifetime],
      );

      if (result.isEmpty) {
        return false;
      } else {
        // Falls back to the locked state on failure so that a database error
        // can never grant the entitlement by accident.
        return result.first[_columnHasPremiumLifetime] == 1;
      }
    } on DatabaseException catch (_) {
      return false;
    }
  }

  @override
  Future<void> markIsPremium() async {
    try {
      final db = await _localDatabase.database;
      final response = await db.query(_tableName);
      if (response.isNotEmpty) {
        await db.update(_tableName, {_columnHasPremiumLifetime: 1});
      }
    } on DatabaseException catch (_) {}
  }
}
