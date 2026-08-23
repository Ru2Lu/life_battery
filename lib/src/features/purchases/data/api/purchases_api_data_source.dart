// More store operations are added as the purchase flow is implemented.
// ignore: one_member_abstracts
abstract interface class PurchasesApiDataSource {
  Future<bool> isAvailable();
}
