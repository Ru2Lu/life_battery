import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/remove_ads_list_tile.dart';

import '../../../../../test_helpers/fake_entitlements.dart';
import '../../../../../test_helpers/test_app.dart';

void main() {
  late FakeEntitlementsLocalDataSource fakeEntitlements;

  Widget buildTile() {
    return ProviderScope(
      overrides: [
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
}
