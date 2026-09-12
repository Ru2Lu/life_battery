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
    extends $NotifierProvider<PurchaseUpdates, PremiumPurchaseStatus> {
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
  Override overrideWithValue(PremiumPurchaseStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PremiumPurchaseStatus>(value),
    );
  }
}

String _$purchaseUpdatesHash() => r'c39e488e02a053b421c7c023d3de71aa0619a452';

/// Listens to the store purchase stream for the whole app session.
///
/// keepAlive because purchases can complete outside the settings screen:
/// deferred purchases (Ask to Buy) may be approved days later and are
/// delivered right after app start.

abstract class _$PurchaseUpdates extends $Notifier<PremiumPurchaseStatus> {
  PremiumPurchaseStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PremiumPurchaseStatus, PremiumPurchaseStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PremiumPurchaseStatus, PremiumPurchaseStatus>,
              PremiumPurchaseStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
