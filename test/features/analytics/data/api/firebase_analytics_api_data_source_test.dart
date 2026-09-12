import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_battery/src/features/analytics/data/api/firebase_analytics_api_data_source.dart';

class _RecordingFirebaseAnalytics extends Fake implements FirebaseAnalytics {
  final List<String> eventNames = [];

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    eventNames.add(name);
  }
}

void main() {
  test('Sends the paywall view as a paywall_view event', () async {
    final analytics = _RecordingFirebaseAnalytics();
    final dataSource = FirebaseAnalyticsApiDataSource(analytics: analytics);

    await dataSource.logPaywallView();

    expect(analytics.eventNames, ['paywall_view']);
  });
}
