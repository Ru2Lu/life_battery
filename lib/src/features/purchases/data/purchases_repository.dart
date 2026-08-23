import 'package:life_battery/src/features/purchases/data/api/purchases_api_data_source.dart';

class PurchasesRepository {
  const PurchasesRepository({required PurchasesApiDataSource apiDataSource})
    : _apiDataSource = apiDataSource;

  final PurchasesApiDataSource _apiDataSource;

  /// Whether the store is available on this device.
  Future<bool> isAvailable() {
    return _apiDataSource.isAvailable();
  }
}
