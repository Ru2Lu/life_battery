// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_notification_use_case_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scheduleNotificationUseCase)
const scheduleNotificationUseCaseProvider =
    ScheduleNotificationUseCaseProvider._();

final class ScheduleNotificationUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<ScheduleNotificationUseCase>,
          ScheduleNotificationUseCase,
          FutureOr<ScheduleNotificationUseCase>
        >
    with
        $FutureModifier<ScheduleNotificationUseCase>,
        $FutureProvider<ScheduleNotificationUseCase> {
  const ScheduleNotificationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleNotificationUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleNotificationUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<ScheduleNotificationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ScheduleNotificationUseCase> create(Ref ref) {
    return scheduleNotificationUseCase(ref);
  }
}

String _$scheduleNotificationUseCaseHash() =>
    r'3efe2991d958d982c3a6728d237ca12b883e0332';
