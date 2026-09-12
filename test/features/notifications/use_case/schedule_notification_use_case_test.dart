import 'package:flutter_test/flutter_test.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository.dart';
import 'package:life_battery/src/features/lifespan/domain/lifespan_range.dart';
import 'package:life_battery/src/features/notifications/data/notification_repository.dart';
import 'package:life_battery/src/features/notifications/use_case/schedule_notification_use_case.dart';

import '../../../../test_helpers/fake_analytics.dart';

class _FakeNotificationRepository extends NotificationRepository {
  _FakeNotificationRepository({required this.granted});

  final bool granted;
  int scheduleCount = 0;

  @override
  Future<bool> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    scheduleCount++;
    return granted;
  }
}

void main() {
  late FakeAnalyticsApiDataSource fakeAnalytics;

  setUp(() {
    fakeAnalytics = FakeAnalyticsApiDataSource();
  });

  ScheduleNotificationUseCase buildUseCase({
    required _FakeNotificationRepository repository,
  }) {
    return ScheduleNotificationUseCase(
      repository: repository,
      analyticsRepository: AnalyticsRepository(apiDataSource: fakeAnalytics),
    );
  }

  Future<void> execute(ScheduleNotificationUseCase useCase) {
    return useCase.execute(
      title: 'title',
      body: 'body',
      lifespanRange: LifespanRange(
        birthDate: DateTime(2000),
        idealAge: 100,
      ),
    );
  }

  test('Logs the granted permission result', () async {
    final repository = _FakeNotificationRepository(granted: true);
    final useCase = buildUseCase(repository: repository);

    await execute(useCase);

    expect(fakeAnalytics.notificationPermissionResults, [true]);
  });

  test('Logs the denied permission result', () async {
    final repository = _FakeNotificationRepository(granted: false);
    final useCase = buildUseCase(repository: repository);

    await execute(useCase);

    expect(fakeAnalytics.notificationPermissionResults, [false]);
  });

  test('Logs the permission result only once per use case instance', () async {
    final repository = _FakeNotificationRepository(granted: true);
    final useCase = buildUseCase(repository: repository);

    await execute(useCase);
    await execute(useCase);

    expect(repository.scheduleCount, 2);
    expect(fakeAnalytics.notificationPermissionResults, [true]);
  });
}
