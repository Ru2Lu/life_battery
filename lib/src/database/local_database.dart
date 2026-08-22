import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();
  static final _instance = LocalDatabase._internal();

  static const _databaseName = 'app_database.db';
  static const _databaseVersion = 8;

  static const _tableName = 'lifespan';
  static const _columnId = 'id';
  static const _columnBirthDate = 'birthDate';
  static const _columnIdealAge = 'idealAge';
  static const _columnThemeMode = 'themeMode';
  static const _columnIsInitialUser = 'isInitialUser';
  static const _columnIsDeletedUser = 'isDeletedUser';
  static const _columnHasLongPressedBattery = 'hasLongPressedBattery';
  static const _columnIsPercentageMode = 'isPercentageMode';
  static const _columnHasRemovedAds = 'hasRemovedAds';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      if (kDebugMode) {
        print('dbPath: $dbPath');
      }
      final path = join(dbPath, _databaseName);

      return openDatabase(
        path,
        version: _databaseVersion,
        onCreate: (db, _) async {
          await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $_columnBirthDate TEXT NOT NULL,
            $_columnIdealAge INTEGER NOT NULL,
            $_columnThemeMode TEXT NOT NULL,
            $_columnIsInitialUser INTEGER NOT NULL,
            $_columnIsDeletedUser INTEGER NOT NULL,
            $_columnHasLongPressedBattery INTEGER NOT NULL,
            $_columnIsPercentageMode INTEGER NOT NULL,
            $_columnHasRemovedAds INTEGER NOT NULL
          )
        ''');

          await db.insert(
            _tableName,
            {
              _columnBirthDate: '1980-01-01T00:00:00.000',
              _columnIdealAge: 100,
              _columnThemeMode: 'system',
              _columnIsInitialUser: 1,
              _columnIsDeletedUser: 0,
              _columnHasLongPressedBattery: 0,
              _columnIsPercentageMode: 1,
              _columnHasRemovedAds: 0,
            },
          );
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 5) {
            // Replace deathDate with idealAge so users can specify their
            // target lifespan as a number of years rather than a specific date.
            // Reset isInitialUser to true so existing users see the new age
            // slider UI.
            await db.execute(
              'ALTER TABLE $_tableName ADD COLUMN $_columnIdealAge INTEGER',
            );
            await db.update(
              _tableName,
              {
                _columnIdealAge: 100,
                _columnIsInitialUser: 1,
              },
            );
          }
          if (oldVersion < 6) {
            await db.execute(
              'ALTER TABLE $_tableName '
              'ADD COLUMN $_columnHasLongPressedBattery INTEGER NOT NULL '
              'DEFAULT 0',
            );
          }
          if (oldVersion < 7) {
            await db.execute(
              'ALTER TABLE $_tableName '
              'ADD COLUMN $_columnIsPercentageMode INTEGER NOT NULL '
              'DEFAULT 1',
            );
          }
          if (oldVersion < 8) {
            await db.execute(
              'ALTER TABLE $_tableName '
              'ADD COLUMN $_columnHasRemovedAds INTEGER NOT NULL '
              'DEFAULT 0',
            );
          }
        },
      );
    } catch (e) {
      throw Exception('Failed to initialize the database $e');
    }
  }
}
