import 'package:life_battery/src/features/purchases/data/home_widget/entitlements_home_widget_data_source.dart';
import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';

class EntitlementsRepository {
  const EntitlementsRepository({
    required EntitlementsLocalDataSource localDataSource,
    required EntitlementsHomeWidgetDataSource homeWidgetDataSource,
  }) : _localDataSource = localDataSource,
       _homeWidgetDataSource = homeWidgetDataSource;

  final EntitlementsLocalDataSource _localDataSource;
  final EntitlementsHomeWidgetDataSource _homeWidgetDataSource;

  /// Decides whether the user is entitled to the premium features
  /// (ad removal and the home screen widget).
  Future<bool> isPremium() async {
    final entitlement = await _localDataSource.getEntitlement();
    return entitlement.isActive(DateTime.now());
  }

  Future<void> markPremiumPurchased() {
    return _localDataSource.markLifetimePurchased();
  }

  /// Stores a subscription entitlement valid until [expiresAt].
  Future<void> markPremiumSubscribed({required DateTime expiresAt}) {
    return _localDataSource.markSubscribedUntil(expiresAt);
  }

  /// Pushes the premium entitlement to the home screen widget so it can
  /// switch between the battery view and the locked view.
  Future<void> syncPremiumToWidget({required bool isPremium}) {
    return _homeWidgetDataSource.syncIsWidgetUnlocked(isUnlocked: isPremium);
  }
}
