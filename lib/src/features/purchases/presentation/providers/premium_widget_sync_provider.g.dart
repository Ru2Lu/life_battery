// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_widget_sync_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors the premium entitlement to the home screen widget.
///
/// keepAlive and watched at startup so the widget reflects the entitlement
/// after a purchase, a restore, or a reinstall. Re-runs whenever
/// [isPremiumProvider] is invalidated by a purchase event.

@ProviderFor(premiumWidgetSync)
const premiumWidgetSyncProvider = PremiumWidgetSyncProvider._();

/// Mirrors the premium entitlement to the home screen widget.
///
/// keepAlive and watched at startup so the widget reflects the entitlement
/// after a purchase, a restore, or a reinstall. Re-runs whenever
/// [isPremiumProvider] is invalidated by a purchase event.

final class PremiumWidgetSyncProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Mirrors the premium entitlement to the home screen widget.
  ///
  /// keepAlive and watched at startup so the widget reflects the entitlement
  /// after a purchase, a restore, or a reinstall. Re-runs whenever
  /// [isPremiumProvider] is invalidated by a purchase event.
  const PremiumWidgetSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumWidgetSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumWidgetSyncHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return premiumWidgetSync(ref);
  }
}

String _$premiumWidgetSyncHash() => r'da9f4807daa3148552966feea17caa846acfed6a';
