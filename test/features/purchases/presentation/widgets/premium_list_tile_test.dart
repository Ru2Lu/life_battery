import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository_provider.dart';
import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/premium_list_tile.dart';

import '../../../../../test_helpers/fake_analytics.dart';
import '../../../../../test_helpers/fake_entitlements.dart';
import '../../../../../test_helpers/fake_purchases.dart';
import '../../../../../test_helpers/test_app.dart';

void main() {
  late FakePurchasesApiDataSource fakeApi;
  late FakeEntitlementsLocalDataSource fakeEntitlements;
  late FakeAnalyticsApiDataSource fakeAnalytics;

  Widget buildTile() {
    return ProviderScope(
      overrides: [
        purchasesApiDataSourceProvider.overrideWithValue(fakeApi),
        entitlementsLocalDataSourceProvider.overrideWithValue(
          fakeEntitlements,
        ),
        analyticsApiDataSourceProvider.overrideWithValue(fakeAnalytics),
      ],
      child: const TestApp(
        home: Scaffold(body: PremiumListTile()),
      ),
    );
  }

  setUp(() {
    fakeApi = FakePurchasesApiDataSource();
    fakeEntitlements = FakeEntitlementsLocalDataSource();
    fakeAnalytics = FakeAnalyticsApiDataSource();
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
      find.text('Unlock all features'),
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
