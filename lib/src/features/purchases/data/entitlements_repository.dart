import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';

class EntitlementsRepository {
  const EntitlementsRepository({
    required EntitlementsLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final EntitlementsLocalDataSource _localDataSource;

  /// Decides whether the user is entitled to the premium features
  /// (ad removal and the home screen widget).
  Future<bool> isPremium() {
    return _localDataSource.getIsPremium();
  }

  Future<void> markPremiumPurchased() {
    return _localDataSource.markIsPremium();
  }
}
