import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';

class FirebaseAnalyticsApiDataSource implements AnalyticsApiDataSource {
  FirebaseAnalyticsApiDataSource({required FirebaseAnalytics analytics})
    : _analytics = analytics;

  final FirebaseAnalytics _analytics;

  @override
  Future<void> logPaywallView() {
    return _analytics.logEvent(name: 'paywall_view');
  }
}
