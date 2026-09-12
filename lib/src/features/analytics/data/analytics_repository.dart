import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';

/// Records product analytics events.
///
/// UI code logs through the typed methods here so event names and
/// parameters stay defined in one place.
class AnalyticsRepository {
  const AnalyticsRepository({required AnalyticsApiDataSource apiDataSource})
    : _apiDataSource = apiDataSource;

  final AnalyticsApiDataSource _apiDataSource;

  Future<void> logOnboardingComplete() {
    return _apiDataSource.logOnboardingComplete();
  }

  Future<void> logPaywallView() {
    return _apiDataSource.logPaywallView();
  }

  Future<void> logPurchaseStart({required PremiumPlan plan}) {
    return _apiDataSource.logPurchaseStart(plan: plan);
  }

  Future<void> logPurchaseComplete({required PremiumPlan plan}) {
    return _apiDataSource.logPurchaseComplete(plan: plan);
  }

  Future<void> logPurchaseCancel({required PremiumPlan plan}) {
    return _apiDataSource.logPurchaseCancel(plan: plan);
  }

  Future<void> logPurchaseError({required PremiumPlan plan}) {
    return _apiDataSource.logPurchaseError(plan: plan);
  }

  Future<void> logSubscriptionRenew() {
    return _apiDataSource.logSubscriptionRenew();
  }
}
