import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/api/purchases_api_data_source.dart';

class InAppPurchasePurchasesApiDataSource implements PurchasesApiDataSource {
  InAppPurchase get _inAppPurchase => InAppPurchase.instance;

  @override
  Future<bool> isAvailable() {
    return _inAppPurchase.isAvailable();
  }
}
