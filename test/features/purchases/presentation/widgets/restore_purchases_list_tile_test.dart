import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/restore_purchases_list_tile.dart';

import '../../../../../test_helpers/fake_purchases.dart';
import '../../../../../test_helpers/test_app.dart';

void main() {
  late FakePurchasesApiDataSource fakeApi;

  Widget buildTile() {
    return ProviderScope(
      overrides: [
        purchasesApiDataSourceProvider.overrideWithValue(fakeApi),
      ],
      child: const TestApp(
        home: Scaffold(body: RestorePurchasesListTile()),
      ),
    );
  }

  setUp(() {
    fakeApi = FakePurchasesApiDataSource();
  });

  testWidgets('Displays restore purchases label', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());

    expect(find.text('Restore purchases'), findsOneWidget);
  });

  testWidgets('Displays Japanese restore purchases label', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('ja')];
    await tester.pumpWidget(buildTile());

    expect(find.text('以前の購入を復元'), findsOneWidget);
  });

  testWidgets('Requests the restore and shows progress when tapped', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());

    await tester.tap(find.text('Restore purchases'));
    await tester.pump();

    expect(fakeApi.restoreCallCount, 1);
    expect(find.text('Restoring purchases...'), findsOneWidget);
  });
}
