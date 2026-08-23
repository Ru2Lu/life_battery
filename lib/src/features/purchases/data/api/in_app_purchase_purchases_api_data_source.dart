import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/api/product_ids.dart';
import 'package:life_battery/src/features/purchases/data/api/purchases_api_data_source.dart';

class InAppPurchasePurchasesApiDataSource implements PurchasesApiDataSource {
  InAppPurchase get _inAppPurchase => InAppPurchase.instance;

  @override
  Stream<List<PurchaseDetails>> get purchaseStream =>
      _inAppPurchase.purchaseStream;

  @override
  Future<bool> isAvailable() {
    return _inAppPurchase.isAvailable();
  }

  @override
  Future<ProductDetails?> fetchRemoveAdsProduct() async {
    final response = await _inAppPurchase.queryProductDetails(ProductIds.all);
    for (final product in response.productDetails) {
      if (product.id == ProductIds.removeAds) {
        return product;
      }
    }
    return null;
  }

}
