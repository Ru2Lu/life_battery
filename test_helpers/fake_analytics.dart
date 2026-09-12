import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';

class FakeAnalyticsApiDataSource implements AnalyticsApiDataSource {
  int paywallViewCount = 0;
  final List<PremiumPlan> purchaseStarts = [];
  final List<PremiumPlan> purchaseCompletes = [];
  final List<PremiumPlan> purchaseCancels = [];
  final List<PremiumPlan> purchaseErrors = [];
  int subscriptionRenewCount = 0;

  @override
  Future<void> logPaywallView() async {
    paywallViewCount++;
  }

  @override
  Future<void> logPurchaseStart({required PremiumPlan plan}) async {
    purchaseStarts.add(plan);
  }

  @override
  Future<void> logPurchaseComplete({required PremiumPlan plan}) async {
    purchaseCompletes.add(plan);
  }

  @override
  Future<void> logPurchaseCancel({required PremiumPlan plan}) async {
    purchaseCancels.add(plan);
  }

  @override
  Future<void> logPurchaseError({required PremiumPlan plan}) async {
    purchaseErrors.add(plan);
  }

  @override
  Future<void> logSubscriptionRenew() async {
    subscriptionRenewCount++;
  }
}
