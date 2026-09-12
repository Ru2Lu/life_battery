import 'package:life_battery/src/features/purchases/domain/premium_entitlement.dart';

abstract interface class EntitlementsLocalDataSource {
  Future<PremiumEntitlement> getEntitlement();

  /// Stores the lifetime purchase.
  Future<void> markLifetimePurchased();

  /// Stores the subscription expiry.
  Future<void> markSubscribedUntil(DateTime expiresAt);
}
