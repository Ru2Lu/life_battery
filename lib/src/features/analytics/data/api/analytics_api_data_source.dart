import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';

abstract interface class AnalyticsApiDataSource {
  Future<void> logPaywallView();

  Future<void> logPurchaseStart({required PremiumPlan plan});
}
