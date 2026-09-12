import 'package:life_battery/src/features/purchases/data/home_widget/entitlements_home_widget_data_source.dart';
import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_entitlement.dart';

class FakeEntitlementsLocalDataSource implements EntitlementsLocalDataSource {
  FakeEntitlementsLocalDataSource({bool isPremium = false})
    : entitlement = PremiumEntitlement(hasLifetime: isPremium);

  PremiumEntitlement entitlement;

  bool get isPremium => entitlement.hasLifetime;

  set isPremium(bool value) {
    entitlement = PremiumEntitlement(hasLifetime: value);
  }

  @override
  Future<PremiumEntitlement> getEntitlement() async => entitlement;

  @override
  Future<void> markLifetimePurchased() async {
    entitlement = PremiumEntitlement(
      hasLifetime: true,
      subscriptionExpiresAt: entitlement.subscriptionExpiresAt,
    );
  }

  @override
  Future<void> markSubscribedUntil(DateTime expiresAt) async {
    entitlement = PremiumEntitlement(
      hasLifetime: entitlement.hasLifetime,
      subscriptionExpiresAt: expiresAt,
    );
  }
}

class FakeEntitlementsHomeWidgetDataSource
    implements EntitlementsHomeWidgetDataSource {
  final syncedValues = <bool>[];

  @override
  Future<void> syncIsWidgetUnlocked({required bool isUnlocked}) async {
    syncedValues.add(isUnlocked);
  }
}
