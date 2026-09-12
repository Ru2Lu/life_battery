import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';

/// Records analytics calls in memory for assertions.
class FakeAnalyticsApiDataSource implements AnalyticsApiDataSource {
  /// The number of times [logPaywallView] was called.
  int paywallViewCount = 0;

  @override
  Future<void> logPaywallView() async {
    paywallViewCount++;
  }
}
