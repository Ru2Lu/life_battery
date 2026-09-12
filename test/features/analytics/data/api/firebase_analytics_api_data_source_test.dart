import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_battery/src/features/analytics/data/api/firebase_analytics_api_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';

class _RecordingFirebaseAnalytics extends Fake implements FirebaseAnalytics {
  final List<({String name, Map<String, Object>? parameters})> events = [];

  @override
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    events.add((name: name, parameters: parameters));
  }
}

void main() {
  late _RecordingFirebaseAnalytics analytics;
  late FirebaseAnalyticsApiDataSource dataSource;

  setUp(() {
    analytics = _RecordingFirebaseAnalytics();
    dataSource = FirebaseAnalyticsApiDataSource(analytics: analytics);
  });

  test('Sends the onboarding completion as an onboarding_complete event',
      () async {
    await dataSource.logOnboardingComplete();

    expect(analytics.events.single.name, 'onboarding_complete');
    expect(analytics.events.single.parameters, isNull);
  });

  test('Sends the paywall view as a paywall_view event', () async {
    await dataSource.logPaywallView();

    expect(analytics.events.single.name, 'paywall_view');
    expect(analytics.events.single.parameters, isNull);
  });

  test('Sends the purchase start as a purchase_start event with the plan',
      () async {
    await dataSource.logPurchaseStart(plan: PremiumPlan.monthly);

    expect(analytics.events.single.name, 'purchase_start');
    expect(analytics.events.single.parameters, {'plan': 'monthly'});
  });

  test('Sends the purchase complete as a purchase_complete event with the plan',
      () async {
    await dataSource.logPurchaseComplete(plan: PremiumPlan.lifetime);

    expect(analytics.events.single.name, 'purchase_complete');
    expect(analytics.events.single.parameters, {'plan': 'lifetime'});
  });

  test('Sends the purchase cancel as a purchase_cancel event with the plan',
      () async {
    await dataSource.logPurchaseCancel(plan: PremiumPlan.monthly);

    expect(analytics.events.single.name, 'purchase_cancel');
    expect(analytics.events.single.parameters, {'plan': 'monthly'});
  });

  test('Sends the purchase error as a purchase_error event with the plan',
      () async {
    await dataSource.logPurchaseError(plan: PremiumPlan.lifetime);

    expect(analytics.events.single.name, 'purchase_error');
    expect(analytics.events.single.parameters, {'plan': 'lifetime'});
  });

  test('Sends the subscription renew as a subscription_renew event', () async {
    await dataSource.logSubscriptionRenew();

    expect(analytics.events.single.name, 'subscription_renew');
    expect(analytics.events.single.parameters, isNull);
  });
}
