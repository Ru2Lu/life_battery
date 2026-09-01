import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/premium_list_tile.dart';

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
        home: Scaffold(body: PremiumListTile()),
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

    expect(find.text('Premium'), findsOneWidget);
    expect(find.text('Purchased'), findsNothing);
    expect(find.byIcon(Icons.check), findsNothing);
  });

  testWidgets('Describes the premium features when not entitled', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(
      find.text('Removes ads and unlocks the home screen widget.'),
      findsOneWidget,
    );
  });

  testWidgets('Displays purchased state when entitled', (tester) async {
    fakeEntitlements.isPremium = true;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('Purchased'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('Displays Japanese purchased state when entitled', (
    tester,
  ) async {
    fakeEntitlements.isPremium = true;

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

    expect(find.text('Premium'), findsOneWidget);
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
    fakeEntitlements.isPremium = true;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    expect(find.text('Purchased'), findsOneWidget);
    expect(find.text('The store is currently unavailable.'), findsNothing);
  });

  testWidgets('Opens the bottom sheet with the purchase button when tapped', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Premium'));
    await tester.pumpAndSettle();

    expect(find.text('Make the most of your time'), findsOneWidget);
    expect(find.text('5 stars'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNWidgets(5));
    expect(find.text('Purchase'), findsOneWidget);
    expect(fakeApi.boughtProducts, isEmpty);
  });

  testWidgets('Requests the purchase from the bottom sheet button', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Premium'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Purchase'));
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

    await tester.tap(find.text('Premium'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Purchase'));
    await tester.pump();
    await tester.pump();

    expect(
      find.text('The purchase could not be completed. Please try again.'),
      findsOneWidget,
    );
  });

  testWidgets('Closes the bottom sheet on a purchase event', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Premium'));
    await tester.pumpAndSettle();

    fakeApi.controller.add([
      buildPurchaseDetails(
        status: PurchaseStatus.purchased,
        pendingCompletePurchase: true,
      ),
    ]);
    await tester.pumpAndSettle();

    expect(find.text('Purchase'), findsNothing);
    expect(find.text('Purchased'), findsOneWidget);
  });

  testWidgets('Shows the Japanese bottom sheet when tapped', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('ja')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    await tester.tap(find.text('プレミアム'));
    await tester.pumpAndSettle();

    expect(find.text('残りの時間をもっと大切に'), findsOneWidget);
    expect(find.text('5 stars'), findsOneWidget);
    expect(find.text('購入'), findsOneWidget);
  });

  testWidgets('Ignores taps when entitled', (tester) async {
    fakeEntitlements.isPremium = true;

    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Premium'));
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

    expect(
      find.text('Thank you! Premium features are now unlocked.'),
      findsOneWidget,
    );
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
