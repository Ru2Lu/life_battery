import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/api/purchases_api_data_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';

class FakePurchasesApiDataSource implements PurchasesApiDataSource {
  FakePurchasesApiDataSource({
    this.available = true,
    ProductDetails? product,
    this.buyResult = true,
  }) : product = product ?? defaultPremiumProduct;

  static final defaultPremiumProduct = ProductDetails(
    id: PremiumPlan.lifetime.productId,
    title: 'Premium',
    description: 'Removes ads and unlocks the widget',
    price: r'$1.00',
    rawPrice: 1,
    currencyCode: 'USD',
  );

  static final defaultMonthlyProduct = ProductDetails(
    id: PremiumPlan.monthly.productId,
    title: 'Premium Monthly',
    description: 'Removes ads and unlocks the widget',
    price: r'$0.99',
    rawPrice: 0.99,
    currencyCode: 'USD',
  );

  final controller = StreamController<List<PurchaseDetails>>.broadcast();

  bool available;
  ProductDetails? product;
  ProductDetails? monthlyProduct = defaultMonthlyProduct;
  bool buyResult;

  final boughtProducts = <ProductDetails>[];
  int restoreCallCount = 0;
  final completedPurchases = <PurchaseDetails>[];

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => controller.stream;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<List<ProductDetails>> fetchPremiumProducts() async => [
    ?product,
    ?monthlyProduct,
  ];

  @override
  Future<bool> buyNonConsumable({required ProductDetails product}) async {
    boughtProducts.add(product);
    return buyResult;
  }

  @override
  Future<void> restorePurchases() async {
    restoreCallCount++;
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) async {
    completedPurchases.add(purchase);
  }
}

PurchaseDetails buildPurchaseDetails({
  required PurchaseStatus status,
  String? productID,
  bool pendingCompletePurchase = false,
}) {
  return PurchaseDetails(
    productID: productID ?? PremiumPlan.lifetime.productId,
    verificationData: PurchaseVerificationData(
      localVerificationData: 'local',
      serverVerificationData: 'server',
      source: 'test',
    ),
    transactionDate: null,
    status: status,
  )..pendingCompletePurchase = pendingCompletePurchase;
}
