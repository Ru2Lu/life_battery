import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';
import 'package:life_battery/src/features/purchases/domain/premium_purchase_status.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_premium_provider.dart';
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
  PremiumPurchaseStatus build() {
    final repository = ref.watch(purchasesRepositoryProvider);
    final subscription = repository.purchaseStream.listen(_onPurchaseUpdates);
    ref.onDispose(subscription.cancel);
    return PremiumPurchaseStatus.none;
  }

  Future<void> _onPurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      await _handlePurchase(purchase);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchase) async {
    switch (purchase.status) {
      case PurchaseStatus.purchased || PurchaseStatus.restored:
        if (PremiumPlan.allProductIds.contains(purchase.productID)) {
          await ref.read(entitlementsRepositoryProvider).markPremiumPurchased();
          ref.invalidate(isPremiumProvider);
          state = purchase.status == PurchaseStatus.purchased
              ? PremiumPurchaseStatus.purchased
              : PremiumPurchaseStatus.restored;
        }
      case PurchaseStatus.pending:
        state = PremiumPurchaseStatus.pending;
      case PurchaseStatus.error:
        state = PremiumPurchaseStatus.error;
      case PurchaseStatus.canceled:
        state = PremiumPurchaseStatus.canceled;
    }

    // Required for every finished transaction regardless of status to
    // avoid transactions getting stuck in the store queue.
    if (purchase.pendingCompletePurchase) {
      await ref.read(purchasesRepositoryProvider).completePurchase(purchase);
    }
  }
}
