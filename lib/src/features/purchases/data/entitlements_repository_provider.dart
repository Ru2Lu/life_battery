import 'package:life_battery/src/database/local_database_provider.dart';
import 'package:life_battery/src/features/purchases/data/entitlements_repository.dart';
import 'package:life_battery/src/features/purchases/data/local/cache_entitlements_local_data_source.dart';
import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'entitlements_repository_provider.g.dart';

@Riverpod(keepAlive: true)
EntitlementsLocalDataSource entitlementsLocalDataSource(Ref ref) {
  final database = ref.watch(localDatabaseProvider);
  return CacheEntitlementsLocalDataSource(localDatabase: database);
}

@Riverpod(keepAlive: true)
EntitlementsRepository entitlementsRepository(Ref ref) {
  final localDataSource = ref.watch(entitlementsLocalDataSourceProvider);
  return EntitlementsRepository(localDataSource: localDataSource);
}
