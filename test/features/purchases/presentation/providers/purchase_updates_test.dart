import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/api/product_ids.dart';
import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/remove_ads_purchase_status.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_ad_free_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/purchase_updates_provider.dart';

import '../../../../../test_helpers/fake_entitlements.dart';
import '../../../../../test_helpers/fake_purchases.dart';

void main() {
  late FakePurchasesApiDataSource fakeApi;
  late FakeEntitlementsLocalDataSource fakeEntitlements;
  late ProviderContainer container;

  setUp(() {
    fakeApi = FakePurchasesApiDataSource();
    fakeEntitlements = FakeEntitlementsLocalDataSource();
    container = ProviderContainer(
      overrides: [
        purchasesApiDataSourceProvider.overrideWithValue(fakeApi),
        entitlementsLocalDataSourceProvider.overrideWithValue(
          fakeEntitlements,
        ),
      ],
    );
    addTearDown(container.dispose);
    container.read(purchaseUpdatesProvider);
  });

  Future<void> emit(
    PurchaseStatus status, {
    String productID = ProductIds.removeAds,
    bool pendingCompletePurchase = false,
  }) async {
    fakeApi.controller.add([
      buildPurchaseDetails(
        status: status,
        productID: productID,
        pendingCompletePurchase: pendingCompletePurchase,
      ),
    ]);
    await Future<void>.delayed(Duration.zero);
  }

  test('Reports purchased on a remove_ads purchase event', () async {
    await emit(PurchaseStatus.purchased);

    expect(
      container.read(purchaseUpdatesProvider),
      RemoveAdsPurchaseStatus.purchased,
    );
  });

  test('Reports restored on a remove_ads restore event', () async {
    await emit(PurchaseStatus.restored);

    expect(
      container.read(purchaseUpdatesProvider),
      RemoveAdsPurchaseStatus.restored,
    );
  });

  test('Ignores purchases of unrelated products', () async {
    await emit(PurchaseStatus.purchased, productID: 'other_product');

    expect(
      container.read(purchaseUpdatesProvider),
      RemoveAdsPurchaseStatus.none,
    );
  });

  test('Reports pending while the purchase awaits approval', () async {
    await emit(PurchaseStatus.pending);

    expect(
      container.read(purchaseUpdatesProvider),
      RemoveAdsPurchaseStatus.pending,
    );
  });

  test('Reports error when the purchase fails', () async {
    await emit(PurchaseStatus.error);

    expect(
      container.read(purchaseUpdatesProvider),
      RemoveAdsPurchaseStatus.error,
    );
  });

  test('Reports canceled when the purchase is canceled', () async {
    await emit(PurchaseStatus.canceled);

    expect(
      container.read(purchaseUpdatesProvider),
      RemoveAdsPurchaseStatus.canceled,
    );
  });

  test('Grants the entitlement and completes a purchase', () async {
    await emit(PurchaseStatus.purchased, pendingCompletePurchase: true);

    expect(fakeEntitlements.hasRemovedAds, isTrue);
    expect(fakeApi.completedPurchases, hasLength(1));
  });

  test('Grants the entitlement on a restore event', () async {
    await emit(PurchaseStatus.restored, pendingCompletePurchase: true);

    expect(fakeEntitlements.hasRemovedAds, isTrue);
    expect(fakeApi.completedPurchases, hasLength(1));
  });

  test('Does not grant the entitlement for unrelated products', () async {
    await emit(
      PurchaseStatus.purchased,
      productID: 'other_product',
      pendingCompletePurchase: true,
    );

    expect(fakeEntitlements.hasRemovedAds, isFalse);
    expect(fakeApi.completedPurchases, hasLength(1));
  });

  test('Does not grant the entitlement while pending', () async {
    await emit(PurchaseStatus.pending);

    expect(fakeEntitlements.hasRemovedAds, isFalse);
    expect(fakeApi.completedPurchases, isEmpty);
  });

  test('Completes a finished transaction even on error', () async {
    await emit(PurchaseStatus.error, pendingCompletePurchase: true);

    expect(fakeEntitlements.hasRemovedAds, isFalse);
    expect(fakeApi.completedPurchases, hasLength(1));
  });

  test('Refreshes isAdFree after a purchase', () async {
    expect(await container.read(isAdFreeProvider.future), isFalse);

    await emit(PurchaseStatus.purchased);

    expect(await container.read(isAdFreeProvider.future), isTrue);
  });
}
