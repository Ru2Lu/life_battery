import 'package:in_app_purchase/in_app_purchase.dart';

abstract interface class PurchasesApiDataSource {
  Stream<List<PurchaseDetails>> get purchaseStream;

  Future<bool> isAvailable();

  Future<List<ProductDetails>> fetchPremiumProducts();

  Future<bool> buyNonConsumable({required ProductDetails product});

  Future<void> restorePurchases();

  Future<void> completePurchase(PurchaseDetails purchase);
}
