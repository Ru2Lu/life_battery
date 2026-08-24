// Kept as a data source interface to match the layer's structure and to
// allow a fake in tests.
// ignore: one_member_abstracts
abstract interface class EntitlementsHomeWidgetDataSource {
  Future<void> syncIsWidgetUnlocked({required bool isUnlocked});
}
