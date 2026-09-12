import 'package:life_battery/src/database/local_database.dart';
import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_entitlement.dart';
import 'package:sqflite/sqflite.dart';

class CacheEntitlementsLocalDataSource implements EntitlementsLocalDataSource {
  const CacheEntitlementsLocalDataSource({
    required LocalDatabase localDatabase,
  }) : _localDatabase = localDatabase;

  final LocalDatabase _localDatabase;

  static const _tableName = 'lifespan';
  static const _columnHasPremiumLifetime = 'hasPremiumLifetime';
  static const _columnPremiumSubscriptionExpiresAt =
      'premiumSubscriptionExpiresAt';

  @override
  Future<PremiumEntitlement> getEntitlement() async {
    try {
      final db = await _localDatabase.database;
      final result = await db.query(
        _tableName,
        columns: [
          _columnHasPremiumLifetime,
          _columnPremiumSubscriptionExpiresAt,
        ],
      );

      if (result.isEmpty) {
        return const PremiumEntitlement.none();
      }

      final row = result.first;
      final expiresAtMillis = row[_columnPremiumSubscriptionExpiresAt] as int?;
      return PremiumEntitlement(
        hasLifetime: row[_columnHasPremiumLifetime] == 1,
        subscriptionExpiresAt: expiresAtMillis == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(expiresAtMillis),
      );
    } on DatabaseException catch (_) {
      // Falls back to the locked state on failure so that a database error
      // can never grant the entitlement by accident.
      return const PremiumEntitlement.none();
    }
  }

  @override
  Future<void> markLifetimePurchased() async {
    try {
      final db = await _localDatabase.database;
      final response = await db.query(_tableName);
      if (response.isNotEmpty) {
        await db.update(_tableName, {_columnHasPremiumLifetime: 1});
      }
    } on DatabaseException catch (_) {}
  }

  @override
  Future<void> markSubscribedUntil(DateTime expiresAt) async {
    try {
      final db = await _localDatabase.database;
      final response = await db.query(_tableName);
      if (response.isNotEmpty) {
        await db.update(_tableName, {
          _columnPremiumSubscriptionExpiresAt: expiresAt.millisecondsSinceEpoch,
        });
      }
    } on DatabaseException catch (_) {}
  }
}
