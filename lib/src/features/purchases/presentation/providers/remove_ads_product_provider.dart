import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_store_available_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remove_ads_product_provider.g.dart';

/// The remove_ads product details, or null when the store is unavailable
/// or the product is not registered.
@riverpod
Future<ProductDetails?> removeAdsProduct(Ref ref) async {
  final isAvailable = await ref.watch(isStoreAvailableProvider.future);
  if (!isAvailable) return null;
  return ref.watch(purchasesRepositoryProvider).fetchRemoveAdsProduct();
}
