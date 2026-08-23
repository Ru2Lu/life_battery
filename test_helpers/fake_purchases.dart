import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/api/product_ids.dart';
import 'package:life_battery/src/features/purchases/data/api/purchases_api_data_source.dart';

class FakePurchasesApiDataSource implements PurchasesApiDataSource {
  FakePurchasesApiDataSource({
    this.available = true,
    ProductDetails? product,
  }) : product = product ?? defaultRemoveAdsProduct;

  static final defaultRemoveAdsProduct = ProductDetails(
    id: ProductIds.removeAds,
    title: 'Remove ads',
    description: 'Removes ads from the app',
    price: r'$1.00',
    rawPrice: 1,
    currencyCode: 'USD',
  );

  final controller = StreamController<List<PurchaseDetails>>.broadcast();

  bool available;
  ProductDetails? product;

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => controller.stream;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<ProductDetails?> fetchRemoveAdsProduct() async => product;

}

PurchaseDetails buildPurchaseDetails({
  required PurchaseStatus status,
  String productID = ProductIds.removeAds,
  bool pendingCompletePurchase = false,
}) {
  return PurchaseDetails(
    productID: productID,
    verificationData: PurchaseVerificationData(
      localVerificationData: 'local',
      serverVerificationData: 'server',
      source: 'test',
    ),
    transactionDate: null,
    status: status,
  )..pendingCompletePurchase = pendingCompletePurchase;
}
