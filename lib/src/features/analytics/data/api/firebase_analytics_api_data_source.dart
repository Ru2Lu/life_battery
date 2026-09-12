import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';

class FirebaseAnalyticsApiDataSource implements AnalyticsApiDataSource {
  FirebaseAnalyticsApiDataSource({required FirebaseAnalytics analytics})
    : _analytics = analytics;

  final FirebaseAnalytics _analytics;

  @override
  Future<void> logPaywallView() {
    return _analytics.logEvent(name: 'paywall_view');
  }

  @override
  Future<void> logPurchaseStart({required PremiumPlan plan}) {
    return _analytics.logEvent(
      name: 'purchase_start',
      parameters: {'plan': plan.name},
    );
  }

  @override
  Future<void> logPurchaseComplete({required PremiumPlan plan}) {
    return _analytics.logEvent(
      name: 'purchase_complete',
      parameters: {'plan': plan.name},
    );
  }

  @override
  Future<void> logPurchaseCancel({required PremiumPlan plan}) {
    return _analytics.logEvent(
      name: 'purchase_cancel',
      parameters: {'plan': plan.name},
    );
  }

  @override
  Future<void> logPurchaseError({required PremiumPlan plan}) {
    return _analytics.logEvent(
      name: 'purchase_error',
      parameters: {'plan': plan.name},
    );
  }
}
