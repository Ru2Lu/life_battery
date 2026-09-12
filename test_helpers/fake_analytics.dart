import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';

/// Records analytics calls in memory for assertions.
class FakeAnalyticsApiDataSource implements AnalyticsApiDataSource {
  /// The number of times [logPaywallView] was called.
  int paywallViewCount = 0;

  /// The plans passed to [logPurchaseStart], in call order.
  final List<PremiumPlan> purchaseStarts = [];

  /// The plans passed to [logPurchaseComplete], in call order.
  final List<PremiumPlan> purchaseCompletes = [];

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
}
