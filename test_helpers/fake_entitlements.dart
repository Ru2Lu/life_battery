import 'package:life_battery/src/features/purchases/data/home_widget/entitlements_home_widget_data_source.dart';
import 'package:life_battery/src/features/purchases/data/local/entitlements_local_data_source.dart';

class FakeEntitlementsLocalDataSource implements EntitlementsLocalDataSource {
  FakeEntitlementsLocalDataSource({this.isPremium = false});

  bool isPremium;

  @override
  Future<bool> getIsPremium() async => isPremium;

  @override
  Future<void> markIsPremium() async {
    isPremium = true;
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
