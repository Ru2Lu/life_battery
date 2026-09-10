import 'dart:async';

import 'package:life_battery/src/database/local_database.dart';
import 'package:life_battery/src/features/data_deletion/data/local/data_deletion_local_data_source.dart';
import 'package:sqflite/sqflite.dart';

class CacheDataDeletionLocalDataSource implements DataDeletionLocalDataSource {
  CacheDataDeletionLocalDataSource({required LocalDatabase localDatabase})
    : _localDatabase = localDatabase {
    // Kick off the async load at construction time so that _isUserDeleted
    // is populated before the router first reads isUserDeleted.
    unawaited(getIsDeletedUser());
  }

  final LocalDatabase _localDatabase;

  bool _isUserDeleted = false;

  final _isUserDeletedState = StreamController<bool>.broadcast();

  static const _tableName = 'lifespan';
  static const _columnBirthDate = 'birthDate';
  static const _columnIdealAge = 'idealAge';
  static const _columnIsInitialUser = 'isInitialUser';
  static const _columnIsDeletedUser = 'isDeletedUser';
  static const _columnHasLongPressedBattery = 'hasLongPressedBattery';
  static const _columnIsPercentageMode = 'isPercentageMode';
  static const _columnHasPremiumLifetime = 'hasPremiumLifetime';

  @override
  Future<bool> getIsDeletedUser() async {
    try {
      final db = await _localDatabase.database;
      final result = await db.query(
        _tableName,
        columns: [_columnIsDeletedUser],
      );

      if (result.isEmpty) {
        _setUserDeleted(false);
        return false;
      } else {
        final isDeletedUser = result.first[_columnIsDeletedUser]! as int;
        _setUserDeleted(isDeletedUser == 1);
        return isDeletedUser == 1;
      }
    } on Exception catch (_) {
      _setUserDeleted(false);
      return false;
    }
  }

  @override
  Future<void> deleteAllData() async {
    try {
      final db = await _localDatabase.database;
      await db.update(_tableName, {
        _columnBirthDate: '1980-01-01T00:00:00.000',
        _columnIdealAge: 100,
        _columnIsInitialUser: 0,
        _columnIsDeletedUser: 1,
        _columnHasLongPressedBattery: 0,
        _columnIsPercentageMode: 1,
        _columnHasPremiumLifetime: 0,
      });
      _setUserDeleted(true);
    } on DatabaseException catch (_) {}
  }

  @override
  bool get isUserDeleted => _isUserDeleted;

  @override
  Stream<bool> isUserDeletedStateChanges() => _isUserDeletedState.stream;

  void _setUserDeleted(bool value) {
    _isUserDeleted = value;
    _isUserDeletedState.add(value);
  }

  void dispose() {
    unawaited(_isUserDeletedState.close());
  }
}
