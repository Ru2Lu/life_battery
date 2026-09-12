import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository_provider.dart';
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

  /// Subscription renewals arrive as purchased events at startup without
  /// a user action, so purchase_complete is only logged for purchased
  /// events preceded by [markPurchaseStarted]. Cleared once the started
  /// purchase reaches any final status.
  bool _hasPurchaseStarted = false;

  void markPurchaseStarted() => _hasPurchaseStarted = true;

  /// The longest monthly billing cycle.
  static const _billingCycleDays = 31;

  /// A renewal transaction only reaches the app on its next launch, so
  /// the expiry is stretched past the billing date to bridge the gap.
  static const _bufferDays = 3;

  static const _subscriptionValidity = Duration(
    days: _billingCycleDays + _bufferDays,
  );

  Future<void> _handlePurchase(PurchaseDetails purchase) async {
    switch (purchase.status) {
      case PurchaseStatus.purchased || PurchaseStatus.restored:
        if (await _grantEntitlement(purchase)) {
          ref.invalidate(isPremiumProvider);
          state = purchase.status == PurchaseStatus.purchased
              ? PremiumPurchaseStatus.purchased
              : PremiumPurchaseStatus.restored;
          if (purchase.status == PurchaseStatus.restored) {
            _hasPurchaseStarted = false;
          }
          final plan = PremiumPlan.fromProductId(purchase.productID);
          if (purchase.status == PurchaseStatus.purchased &&
              plan != null &&
              _hasPurchaseStarted) {
            _hasPurchaseStarted = false;
            unawaited(
              ref
                  .read(analyticsRepositoryProvider)
                  .logPurchaseComplete(plan: plan),
            );
          }
        }
      case PurchaseStatus.pending:
        state = PremiumPurchaseStatus.pending;
      case PurchaseStatus.error:
        state = PremiumPurchaseStatus.error;
        final plan = PremiumPlan.fromProductId(purchase.productID);
        if (plan != null) {
          _hasPurchaseStarted = false;
          unawaited(
            ref.read(analyticsRepositoryProvider).logPurchaseError(plan: plan),
          );
        }
      case PurchaseStatus.canceled:
        state = PremiumPurchaseStatus.canceled;
        final plan = PremiumPlan.fromProductId(purchase.productID);
        if (plan != null) {
          _hasPurchaseStarted = false;
          unawaited(
            ref.read(analyticsRepositoryProvider).logPurchaseCancel(plan: plan),
          );
        }
    }

    // Required for every finished transaction regardless of status to
    // avoid transactions getting stuck in the store queue.
    if (purchase.pendingCompletePurchase) {
      await ref.read(purchasesRepositoryProvider).completePurchase(purchase);
    }
  }

  /// Returns true when [purchase] granted the premium entitlement.
  Future<bool> _grantEntitlement(PurchaseDetails purchase) async {
    final repository = ref.read(entitlementsRepositoryProvider);
    switch (PremiumPlan.fromProductId(purchase.productID)) {
      case PremiumPlan.lifetime:
        await repository.markPremiumPurchased();
        return true;
      case PremiumPlan.monthly:
        final transactionMillis = int.tryParse(purchase.transactionDate ?? '');
        final purchasedAt = transactionMillis == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(transactionMillis);
        await repository.markPremiumSubscribed(
          expiresAt: purchasedAt.add(_subscriptionValidity),
        );
        return true;
      case null:
        return false;
    }
  }
}
