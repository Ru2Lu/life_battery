import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/api/purchases_api_data_source.dart';

class PurchasesRepository {
  const PurchasesRepository({required PurchasesApiDataSource apiDataSource})
    : _apiDataSource = apiDataSource;

  final PurchasesApiDataSource _apiDataSource;

  /// Purchase updates from the store, including deferred ones.
  Stream<List<PurchaseDetails>> get purchaseStream =>
      _apiDataSource.purchaseStream;

  /// Whether the store is available on this device.
  Future<bool> isAvailable() {
    return _apiDataSource.isAvailable();
  }

  /// The remove_ads product, or null when it cannot be fetched.
  Future<ProductDetails?> fetchRemoveAdsProduct() {
    return _apiDataSource.fetchRemoveAdsProduct();
  }

  /// Finishes a store transaction; required for every finished purchase.
  Future<void> completePurchase(PurchaseDetails purchase) {
    return _apiDataSource.completePurchase(purchase);
  }
}
