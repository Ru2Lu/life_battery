import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/remove_ads_list_tile.dart';

import '../../../../../test_helpers/fake_entitlements.dart';
import '../../../../../test_helpers/fake_purchases.dart';
import '../../../../../test_helpers/test_app.dart';

void main() {
  late FakePurchasesApiDataSource fakeApi;
  late FakeEntitlementsLocalDataSource fakeEntitlements;

  Widget buildTile() {
    return ProviderScope(
      overrides: [
        purchasesApiDataSourceProvider.overrideWithValue(fakeApi),
        entitlementsLocalDataSourceProvider.overrideWithValue(
          fakeEntitlements,
        ),
      ],
      child: const TestApp(
        home: Scaffold(body: RemoveAdsListTile()),
      ),
    );
  }

  setUp(() {
    fakeApi = FakePurchasesApiDataSource();
    fakeEntitlements = FakeEntitlementsLocalDataSource();
  });

  testWidgets('Displays label without the purchased state when not entitled', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('Remove ads'), findsOneWidget);
    expect(find.text('Purchased'), findsNothing);
    expect(find.byIcon(Icons.check), findsNothing);
  });

  testWidgets('Displays purchased state when entitled', (tester) async {
    fakeEntitlements.hasRemovedAds = true;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('Purchased'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('Displays Japanese purchased state when entitled', (
    tester,
  ) async {
    fakeEntitlements.hasRemovedAds = true;

    tester.platformDispatcher.localesTestValue = [const Locale('ja')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('購入済み'), findsOneWidget);
  });

  testWidgets('Shows a notice when the store is unavailable', (tester) async {
    fakeApi.available = false;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('Remove ads'), findsOneWidget);
    expect(find.text('The store is currently unavailable.'), findsOneWidget);
  });

  testWidgets('Shows a notice when the product cannot be fetched', (
    tester,
  ) async {
    fakeApi.product = null;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('The store is currently unavailable.'), findsOneWidget);
  });

  testWidgets('Shows a Japanese notice when the store is unavailable', (
    tester,
  ) async {
    fakeApi.available = false;

    tester.platformDispatcher.localesTestValue = [const Locale('ja')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('現在ストアを利用できません。'), findsOneWidget);
  });

  testWidgets('Hides the notice when the store is available', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('The store is currently unavailable.'), findsNothing);
  });

  testWidgets('Hides the notice for the purchased state', (tester) async {
    fakeApi.available = false;
    fakeEntitlements.hasRemovedAds = true;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('Purchased'), findsOneWidget);
    expect(find.text('The store is currently unavailable.'), findsNothing);
  });

  testWidgets('Requests the purchase when tapped', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Remove ads'));
    await tester.pumpAndSettle();

    expect(fakeApi.boughtProducts, [fakeApi.product]);
  });

  testWidgets('Shows an error when the purchase request fails', (
    tester,
  ) async {
    fakeApi.buyResult = false;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Remove ads'));
    await tester.pump();
    await tester.pump();

    expect(
      find.text('The purchase could not be completed. Please try again.'),
      findsOneWidget,
    );
  });

  testWidgets('Ignores taps when entitled', (tester) async {
    fakeEntitlements.hasRemovedAds = true;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Remove ads'));
    await tester.pumpAndSettle();

    expect(fakeApi.boughtProducts, isEmpty);
  });

  testWidgets('Shows success and flips to purchased on a purchase event', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    fakeApi.controller.add([
      buildPurchaseDetails(
        status: PurchaseStatus.purchased,
        pendingCompletePurchase: true,
      ),
    ]);
    await tester.pumpAndSettle();

    expect(find.text('Thank you! Ads have been removed.'), findsOneWidget);
    expect(find.text('Purchased'), findsOneWidget);
    expect(fakeApi.completedPurchases, hasLength(1));
  });

  testWidgets('Shows a pending message on a pending event', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    fakeApi.controller.add([
      buildPurchaseDetails(status: PurchaseStatus.pending),
    ]);
    await tester.pumpAndSettle();

    expect(find.text('Your purchase is pending approval.'), findsOneWidget);
  });
}
