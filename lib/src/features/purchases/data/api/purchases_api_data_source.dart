import 'package:in_app_purchase/in_app_purchase.dart';

abstract interface class PurchasesApiDataSource {
  Stream<List<PurchaseDetails>> get purchaseStream;

  Future<bool> isAvailable();

  Future<ProductDetails?> fetchRemoveAdsProduct();
}
