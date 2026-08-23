// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_updates_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Listens to the store purchase stream for the whole app session.
///
/// keepAlive because purchases can complete outside the settings screen:
/// deferred purchases (Ask to Buy) may be approved days later and are
/// delivered right after app start.

@ProviderFor(PurchaseUpdates)
const purchaseUpdatesProvider = PurchaseUpdatesProvider._();

/// Listens to the store purchase stream for the whole app session.
///
/// keepAlive because purchases can complete outside the settings screen:
/// deferred purchases (Ask to Buy) may be approved days later and are
/// delivered right after app start.
final class PurchaseUpdatesProvider
    extends $NotifierProvider<PurchaseUpdates, RemoveAdsPurchaseStatus> {
  /// Listens to the store purchase stream for the whole app session.
  ///
  /// keepAlive because purchases can complete outside the settings screen:
  /// deferred purchases (Ask to Buy) may be approved days later and are
  /// delivered right after app start.
  const PurchaseUpdatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseUpdatesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseUpdatesHash();

  @$internal
  @override
  PurchaseUpdates create() => PurchaseUpdates();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoveAdsPurchaseStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoveAdsPurchaseStatus>(value),
    );
  }
}

String _$purchaseUpdatesHash() => r'0ebb20752ba7e056119592169adb489ca0ca5e91';

/// Listens to the store purchase stream for the whole app session.
///
/// keepAlive because purchases can complete outside the settings screen:
/// deferred purchases (Ask to Buy) may be approved days later and are
/// delivered right after app start.

abstract class _$PurchaseUpdates extends $Notifier<RemoveAdsPurchaseStatus> {
  RemoveAdsPurchaseStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<RemoveAdsPurchaseStatus, RemoveAdsPurchaseStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RemoveAdsPurchaseStatus, RemoveAdsPurchaseStatus>,
              RemoveAdsPurchaseStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
