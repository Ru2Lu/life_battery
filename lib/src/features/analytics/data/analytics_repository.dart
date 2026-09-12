import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';

/// Records product analytics events.
///
/// UI code logs through the typed methods here so event names and
/// parameters stay defined in one place.
class AnalyticsRepository {
  const AnalyticsRepository({required AnalyticsApiDataSource apiDataSource})
    : _apiDataSource = apiDataSource;

  final AnalyticsApiDataSource _apiDataSource;

  Future<void> logPaywallView() {
    return _apiDataSource.logPaywallView();
  }
}
