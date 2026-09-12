import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/common_widgets/async_value_widget.dart';
import 'package:life_battery/src/extensions/extensions.dart';
import 'package:life_battery/src/features/ads/presentation/widgets/banner_ad_widget.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository_provider.dart';
import 'package:life_battery/src/features/lifespan/domain/lifespan_range.dart';
import 'package:life_battery/src/features/lifespan/presentation/providers/display_mode_manager_provider.dart';
import 'package:life_battery/src/features/lifespan/presentation/providers/has_long_pressed_battery_provider.dart';
import 'package:life_battery/src/features/lifespan/presentation/providers/is_initial_user_provider.dart';
import 'package:life_battery/src/features/lifespan/presentation/providers/lifespan_progress_state_provider.dart';
import 'package:life_battery/src/features/lifespan/presentation/providers/lifespan_range_manager_provider.dart';
import 'package:life_battery/src/features/lifespan/presentation/widgets/battery_indicator.dart';
import 'package:life_battery/src/features/lifespan/presentation/widgets/date_input_bottom_sheet.dart';
import 'package:life_battery/src/features/lifespan/presentation/widgets/long_press_hint.dart';
import 'package:life_battery/src/features/notifications/presentation/providers/notification_schedule_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';
import 'package:life_battery/src/routing/app_route.dart';

class LifespanProgressPage extends ConsumerWidget {
  const LifespanProgressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lifespanProgressState = ref.watch(lifespanProgressStateProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // Keep the battery centered on the full screen even when the banner
      // ad is visible
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.goNamed(AppRoute.settings.name),
          ),
        ],
      ),
      bottomNavigationBar: const BannerAdWidget(),
      body: AsyncValueWidget(
        asyncValue: lifespanProgressState,
        data: (state) => Center(
          child: LifeProgressContent(
            lifespanRange: state.lifespanRange,
            isInitialUser: state.isInitialUser,
            hasLongPressedBattery: state.hasLongPressedBattery,
            isPercentageMode: state.isPercentageMode,
            updateUserIsNotInitialUser: () async {
              await ref
                  .read(isInitialUserProvider.notifier)
                  .updateUserIsNotInitialUser();
            },
            updateHasLongPressedBattery: () async {
              await ref
                  .read(hasLongPressedBatteryProvider.notifier)
                  .updateHasLongPressedBattery();
            },
          ),
        ),
      ),
    );
  }
}

class LifeProgressContent extends HookConsumerWidget {
  const LifeProgressContent({
    required this.lifespanRange,
    required this.isInitialUser,
    required this.hasLongPressedBattery,
    required this.isPercentageMode,
    required this.updateUserIsNotInitialUser,
    required this.updateHasLongPressedBattery,
    super.key,
  });

  final LifespanRange lifespanRange;

  final bool isInitialUser;

  final bool hasLongPressedBattery;

  final bool isPercentageMode;

  final Future<void> Function() updateUserIsNotInitialUser;

  final Future<void> Function() updateHasLongPressedBattery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPressed = useState(false);
    final isNotificationScheduled = useRef(false);

    Future<void> showDateInputBottomSheet() {
      return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return const DateInputBottomSheet();
        },
      );
    }

    Future<void> scheduleNotification() async {
      if (!context.mounted) return;
      final now = DateTime.now();
      final l10n = AppLocalizations.of(context)!;
      final percentage = lifespanRange.remainingLifePercentage(now: now) - 1;
      await ref
          .read(notificationScheduleProvider.notifier)
          .schedule(
            title: l10n.notificationTitle(percentage),
            body: percentage == 0
                ? l10n.notificationBodyZeroPercent
                : l10n.notificationBody,
            lifespanRange: lifespanRange,
          );
      isNotificationScheduled.value = true;
    }

    Future<void> handleLongPress() async {
      if (!hasLongPressedBattery) {
        await updateHasLongPressedBattery();
      }
      if (!context.mounted) return;
      await showDateInputBottomSheet();
    }

    useEffect(() {
      Timer? timer;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (isInitialUser) {
          final birthDateBefore = lifespanRange.birthDate;
          await showDateInputBottomSheet();
          final birthDateAfter = ref
              .read(lifespanRangeManagerProvider)
              .value
              ?.birthDate;
          // Compares values, not picker interaction: a user whose real
          // birth date equals the default is not counted, which is an
          // acceptable loss for this metric.
          if (birthDateAfter != null && birthDateAfter != birthDateBefore) {
            unawaited(
              ref.read(analyticsRepositoryProvider).logOnboardingComplete(),
            );
          }
          if (!context.mounted) return;
        }
        timer = Timer(
          const Duration(seconds: 3),
          () => unawaited(scheduleNotification()),
        );
      });
      unawaited(updateUserIsNotInitialUser());
      return () => timer?.cancel();
    }, const []);

    useEffect(() {
      if (!isNotificationScheduled.value) return null;
      final timer = Timer(
        const Duration(seconds: 1),
        () => unawaited(scheduleNotification()),
      );
      return timer.cancel;
    }, [lifespanRange]);

    final remainingLifePercentage = lifespanRange.remainingLifePercentage(
      now: DateTime.now(),
    );
    final remainingLifeDays = lifespanRange.remainingLifeDays(
      now: DateTime.now(),
    );

    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onLongPress: handleLongPress,
      onTap: () => ref.read(displayModeManagerProvider.notifier).toggle(),
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) => isPressed.value = false,
      onTapCancel: () => isPressed.value = false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: isPressed.value ? 0.90 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: BatteryIndicator(
              value: remainingLifePercentage,
              text: isPercentageMode
                  ? '$remainingLifePercentage%'
                  : '${remainingLifeDays.withCommaString}${l10n.dayUnit}',
            ),
          ),
          const SizedBox(height: 32),
          LongPressHint(
            hasLongPressedBattery: hasLongPressedBattery,
          ),
        ],
      ),
    );
  }
}
