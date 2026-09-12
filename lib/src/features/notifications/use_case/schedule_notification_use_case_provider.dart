import 'package:life_battery/src/features/analytics/data/analytics_repository_provider.dart';
import 'package:life_battery/src/features/notifications/data/notification_repository_provider.dart';
import 'package:life_battery/src/features/notifications/use_case/schedule_notification_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_notification_use_case_provider.g.dart';

// keepAlive so the use case's once-per-session logging state survives
// provider rebuilds.
@Riverpod(keepAlive: true)
Future<ScheduleNotificationUseCase> scheduleNotificationUseCase(Ref ref) async {
  final repository = await ref.watch(notificationRepositoryProvider.future);
  final analyticsRepository = ref.watch(analyticsRepositoryProvider);
  return ScheduleNotificationUseCase(
    repository: repository,
    analyticsRepository: analyticsRepository,
  );
}
