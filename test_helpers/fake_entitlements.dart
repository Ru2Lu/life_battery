import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';

class FakeEntitlementsLocalDataSource implements EntitlementsLocalDataSource {
  FakeEntitlementsLocalDataSource({this.hasRemovedAds = false});

  bool hasRemovedAds;

  @override
  Future<bool> getHasRemovedAds() async => hasRemovedAds;

  @override
  Future<void> markHasRemovedAds() async {
    hasRemovedAds = true;
  }
}
