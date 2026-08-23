import 'package:life_battery/src/features/purchases/data/api/purchases_api_data_source.dart';

class FakePurchasesApiDataSource implements PurchasesApiDataSource {
  FakePurchasesApiDataSource({this.available = true});

  bool available;

  @override
  Future<bool> isAvailable() async => available;
}
