import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/api/product_ids.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/remove_ads_purchase_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'purchase_updates_provider.g.dart';

/// Listens to the store purchase stream for the whole app session.
///
/// keepAlive because purchases can complete outside the settings screen:
/// deferred purchases (Ask to Buy) may be approved days later and are
/// delivered right after app start.
@Riverpod(keepAlive: true)
class PurchaseUpdates extends _$PurchaseUpdates {
  @override
  RemoveAdsPurchaseStatus build() {
    final repository = ref.watch(purchasesRepositoryProvider);
    final subscription = repository.purchaseStream.listen(_onPurchaseUpdates);
    ref.onDispose(subscription.cancel);
    return RemoveAdsPurchaseStatus.none;
  }

  void _onPurchaseUpdates(List<PurchaseDetails> purchases) {
    purchases.forEach(_handlePurchase);
  }

  // Only reflects the store events as status for now. Granting the
  // entitlement and completing the transactions are added with the
  // purchase flow.
  void _handlePurchase(PurchaseDetails purchase) {
    switch (purchase.status) {
      case PurchaseStatus.purchased || PurchaseStatus.restored:
        if (purchase.productID == ProductIds.removeAds) {
          state = purchase.status == PurchaseStatus.purchased
              ? RemoveAdsPurchaseStatus.purchased
              : RemoveAdsPurchaseStatus.restored;
        }
      case PurchaseStatus.pending:
        state = RemoveAdsPurchaseStatus.pending;
      case PurchaseStatus.error:
        state = RemoveAdsPurchaseStatus.error;
      case PurchaseStatus.canceled:
        state = RemoveAdsPurchaseStatus.canceled;
    }
  }
}
