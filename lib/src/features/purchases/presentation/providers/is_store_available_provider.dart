import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_store_available_provider.g.dart';

/// Whether the store is available on this device.
@riverpod
Future<bool> isStoreAvailable(Ref ref) {
  return ref.watch(purchasesRepositoryProvider).isAvailable();
}
