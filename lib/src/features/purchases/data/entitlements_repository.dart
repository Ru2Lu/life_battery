import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';

class EntitlementsRepository {
  const EntitlementsRepository({
    required EntitlementsLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final EntitlementsLocalDataSource _localDataSource;

  /// Decides whether the user is entitled to an ad-free experience.
  Future<bool> isAdFree() {
    return _localDataSource.getHasRemovedAds();
  }

  Future<void> markRemoveAdsPurchased() {
    return _localDataSource.markHasRemovedAds();
  }
}
