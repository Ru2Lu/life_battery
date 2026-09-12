import 'package:life_battery/src/features/analytics/data/analytics_repository.dart';
import 'package:life_battery/src/features/lifespan/domain/lifespan_range.dart';
import 'package:life_battery/src/features/notifications/data/notification_repository.dart';

class ScheduleNotificationUseCase {
  ScheduleNotificationUseCase({
    required NotificationRepository repository,
    required AnalyticsRepository analyticsRepository,
  }) : _repository = repository,
       _analyticsRepository = analyticsRepository;

  final NotificationRepository _repository;

  final AnalyticsRepository _analyticsRepository;

  /// Scheduling runs on every launch and on every lifespan change, so the
  /// permission result is logged at most once per session to avoid flooding
  /// analytics with duplicate events.
  bool _hasLoggedPermissionResult = false;

  Future<void> execute({
    required String title,
    required String body,
    required LifespanRange lifespanRange,
  }) async {
    final now = DateTime.now();
    final dropDate = lifespanRange.nextDropDate(now: now);
    if (dropDate == null) return;

    // Schedule at 9:00 AM on the drop date.
    final scheduledDate = DateTime(
      dropDate.year,
      dropDate.month,
      dropDate.day,
      9,
    );
    final granted = await _repository.scheduleNotification(
      title: title,
      body: body,
      scheduledDate: scheduledDate,
    );

    if (!_hasLoggedPermissionResult) {
      _hasLoggedPermissionResult = true;
      await _analyticsRepository.logNotificationPermissionResult(
        granted: granted,
      );
    }
  }
}
