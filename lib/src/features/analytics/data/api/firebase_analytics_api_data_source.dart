import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/paywall_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';

class FirebaseAnalyticsApiDataSource implements AnalyticsApiDataSource {
  FirebaseAnalyticsApiDataSource({required FirebaseAnalytics analytics})
    : _analytics = analytics;

  final FirebaseAnalytics _analytics;

  /// Prints the event to the console in debug builds, where analytics
  /// collection is normally disabled, so events can be checked without
  /// DebugView.
  Future<void> _logEvent(String name, {Map<String, Object>? parameters}) {
    if (kDebugMode) {
      final params = parameters?.entries
          .map((entry) => ' ${entry.key}=${entry.value}')
          .join();
      debugPrint('[analytics] $name${params ?? ''}');
    }
    return _analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> logOnboardingStart() {
    return _logEvent('onboarding_start');
  }

  @override
  Future<void> logOnboardingComplete() {
    return _logEvent('onboarding_complete');
  }

  @override
  Future<void> logPaywallView({required PaywallSource source}) {
    return _logEvent(
      'paywall_view',
      parameters: {'source': source.paramValue},
    );
  }

  @override
  Future<void> logPurchaseStart({required PremiumPlan plan}) {
    return _logEvent(
      'purchase_start',
      parameters: {'plan': plan.name},
    );
  }

  @override
  Future<void> logPurchaseComplete({required PremiumPlan plan}) {
    return _logEvent(
      'purchase_complete',
      parameters: {'plan': plan.name},
    );
  }

  @override
  Future<void> logPurchaseCancel({required PremiumPlan plan}) {
    return _logEvent(
      'purchase_cancel',
      parameters: {'plan': plan.name},
    );
  }

  @override
  Future<void> logPurchaseError({required PremiumPlan plan}) {
    return _logEvent(
      'purchase_error',
      parameters: {'plan': plan.name},
    );
  }

  @override
  Future<void> logSubscriptionRenew() {
    return _logEvent('subscription_renew');
  }

  @override
  Future<void> logReviewTap() {
    return _logEvent('review_tap');
  }

  @override
  Future<void> logNotificationPermissionResult({required bool granted}) {
    return _logEvent(
      'notification_permission_result',
      parameters: {'granted': granted.toString()},
    );
  }
}
