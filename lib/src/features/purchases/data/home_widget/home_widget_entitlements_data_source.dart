import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:life_battery/src/features/purchases/data/home_widget/entitlements_home_widget_data_source.dart';

class HomeWidgetEntitlementsDataSource
    implements EntitlementsHomeWidgetDataSource {
  const HomeWidgetEntitlementsDataSource();

  @override
  Future<void> syncIsWidgetUnlocked({required bool isUnlocked}) async {
    try {
      // Read by the widget extension to decide between the battery view
      // and the locked view.
      await HomeWidget.saveWidgetData('isWidgetUnlocked', isUnlocked);
      await HomeWidget.updateWidget(
        name: 'LifeBatteryWidget',
        iOSName: 'LifeBatteryWidget',
        androidName: 'LifeBatteryWidgetReceiver',
      );
    } on PlatformException catch (_) {
      // Widget sync may fail in test environments.
    }
  }
}
