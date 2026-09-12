import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository_provider.dart';
import 'package:life_battery/src/features/settings/presentation/widgets/review_app_list_tile.dart';

import '../../../../../test_helpers/fake_analytics.dart';
import '../../../../../test_helpers/test_app.dart';

void main() {
  late FakeAnalyticsApiDataSource fakeAnalytics;

  Widget buildTile() {
    return ProviderScope(
      overrides: [
        analyticsApiDataSourceProvider.overrideWithValue(fakeAnalytics),
      ],
      child: const TestApp(
        home: Scaffold(body: ReviewAppListTile()),
      ),
    );
  }

  setUp(() {
    fakeAnalytics = FakeAnalyticsApiDataSource();
  });

  testWidgets('Logs review_tap when tapped', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('en')];
    await tester.pumpWidget(buildTile());
    await tester.pump();

    await tester.tap(find.byType(ReviewAppListTile));
    await tester.pump();

    expect(fakeAnalytics.reviewTapCount, 1);
  });
}
