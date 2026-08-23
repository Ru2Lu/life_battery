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
  Future<ProductDetails?> fetchPremiumProduct() async {
    final response = await _inAppPurchase.queryProductDetails(ProductIds.all);
    for (final product in response.productDetails) {
      if (product.id == ProductIds.premiumLifetime) {
        return product;
      }
    }
    return null;
  }

  @override
  Future<bool> buyNonConsumable({required ProductDetails product}) async {
    try {
      return await _inAppPurchase.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: product),
      );
    } on Exception catch (_) {
      // The store throws when a purchase is already pending or the item is
      // already owned. The restore flow is the recovery path for the latter.
      return false;
    }
  }

  @override
  Future<void> restorePurchases() {
    return _inAppPurchase.restorePurchases();
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) {
    return _inAppPurchase.completePurchase(purchase);
  }
}
