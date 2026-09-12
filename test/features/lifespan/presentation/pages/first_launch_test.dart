import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository_provider.dart';
import 'package:life_battery/src/features/lifespan/domain/lifespan_range.dart';
import 'package:life_battery/src/features/lifespan/presentation/pages/lifespan_progress_page.dart';
import 'package:life_battery/src/features/lifespan/presentation/providers/lifespan_range_manager_provider.dart';
import 'package:life_battery/src/features/lifespan/presentation/widgets/date_input_bottom_sheet.dart';

import '../../../../../test_helpers/extensions.dart';
import '../../../../../test_helpers/fake_analytics.dart';
import '../../../../../test_helpers/test_app.dart';

void main() {
  late FakeAnalyticsApiDataSource fakeAnalytics;

  setUp(() {
    fakeAnalytics = FakeAnalyticsApiDataSource();
  });

  Widget buildFirstLaunchPage() {
    return ProviderScope(
      overrides: [
        analyticsApiDataSourceProvider.overrideWithValue(fakeAnalytics),
        lifespanRangeManagerProvider.overrideWith(FakeLifespanRangeManager.new),
      ],
      child: TestApp(
        home: Scaffold(
          body: LifeProgressContent(
            lifespanRange: LifespanRange(
              birthDate: DateTime(2000),
              idealAge: 100,
            ),
            isInitialUser: true,
            hasLongPressedBattery: false,
            isPercentageMode: true,
            updateUserIsNotInitialUser: () async {},
            updateHasLongPressedBattery: () async {},
          ),
        ),
      ),
    );
  }

  Future<void> dismissSheet(WidgetTester tester) async {
    await tester.tap(find.byType(ModalBarrier).last);
    await tester.pump();
    await tester.pumpUntilGone(
      find.byType(DateInputBottomSheet),
      timeout: const Duration(seconds: 1),
    );
  }

  group('First launch', () {
    testWidgets('Shows date input bottom sheet for initial user', (
      tester,
    ) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];

      await tester.pumpWidget(buildFirstLaunchPage());
      await tester.pumpUntilFound(find.byType(DateInputBottomSheet));

      expect(find.byType(DateInputBottomSheet), findsOneWidget);
    });

    testWidgets(
      'Logs onboarding_complete when the sheet closes after a '
      'birth date change',
      (tester) async {
        tester.platformDispatcher.localesTestValue = [const Locale('en')];

        await tester.pumpWidget(buildFirstLaunchPage());
        await tester.pumpUntilFound(find.byType(DateInputBottomSheet));

        final container = ProviderScope.containerOf(
          tester.element(find.byType(DateInputBottomSheet)),
        );
        await container
            .read(lifespanRangeManagerProvider.notifier)
            .updateLifespanRange(
              birthDate: DateTime(1995),
              idealAge: 100,
            );
        await tester.pump();

        await dismissSheet(tester);

        expect(fakeAnalytics.onboardingCompleteCount, 1);
      },
    );

    testWidgets(
      'Does not log onboarding_complete when the sheet closes without a '
      'birth date change',
      (tester) async {
        tester.platformDispatcher.localesTestValue = [const Locale('en')];

        await tester.pumpWidget(buildFirstLaunchPage());
        await tester.pumpUntilFound(find.byType(DateInputBottomSheet));

        await dismissSheet(tester);

        expect(fakeAnalytics.onboardingCompleteCount, 0);
      },
    );
  });
}

class FakeLifespanRangeManager extends LifespanRangeManager {
  @override
  Future<LifespanRange> build() async {
    return LifespanRange(
      birthDate: DateTime(2000),
      idealAge: 100,
    );
  }

  @override
  Future<void> updateLifespanRange({
    required DateTime birthDate,
    required int idealAge,
  }) async {
    state = AsyncData(
      LifespanRange(
        birthDate: birthDate,
        idealAge: idealAge,
      ),
    );
  }
}
