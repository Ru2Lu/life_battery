import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/premium_products.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_store_available_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'premium_products_provider.g.dart';

/// The premium plan products, or null when the store is unavailable.
@riverpod
Future<PremiumProducts?> premiumProducts(Ref ref) async {
  final isAvailable = await ref.watch(isStoreAvailableProvider.future);
  if (!isAvailable) return null;
  return ref.watch(purchasesRepositoryProvider).fetchPremiumProducts();
}
