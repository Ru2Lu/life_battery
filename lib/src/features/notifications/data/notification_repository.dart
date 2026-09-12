import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationRepository {
  static final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings(
          'ic_stat_life_battery',
        ),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
    );
  }

  /// Requests permission, cancels existing notifications, and schedules a new
  /// notification at the given [scheduledDate].
  ///
  /// Returns whether the notification permission is granted.
  Future<bool> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final granted = await _requestPermission();
    if (!granted) return false;

    await _cancelAll();

    try {
      await _plugin.zonedSchedule(
        id: 0,
        title: title,
        body: body,
        scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'life_battery_notifications',
            'Life Battery Notifications',
            channelDescription:
                'Notifications for life battery percentage drops',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } on Object catch (error, stack) {
      if (Firebase.apps.isNotEmpty) {
        await FirebaseCrashlytics.instance.recordError(error, stack);
      }
    }
    return true;
  }

  Future<bool> _requestPermission() async {
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    final iosPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return false;
  }

  Future<void> _cancelAll() async {
    await _plugin.cancelAll();
  }
}
