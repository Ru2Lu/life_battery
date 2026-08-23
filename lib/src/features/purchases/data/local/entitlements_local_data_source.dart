abstract interface class EntitlementsLocalDataSource {
  Future<bool> getIsPremium();

  Future<void> markIsPremium();
}
