abstract interface class EntitlementsLocalDataSource {
  Future<bool> getHasRemovedAds();

  Future<void> markHasRemovedAds();
}
