// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_premium_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the user is entitled to the premium features
/// (ad removal and the home screen widget).
///
/// keepAlive because this gates ad loading app-wide and must not be
/// disposed and re-fetched between page navigations. The source of truth
/// is the local database; purchase events update it and invalidate this
/// provider.

@ProviderFor(IsPremium)
const isPremiumProvider = IsPremiumProvider._();

/// Whether the user is entitled to the premium features
/// (ad removal and the home screen widget).
///
/// keepAlive because this gates ad loading app-wide and must not be
/// disposed and re-fetched between page navigations. The source of truth
/// is the local database; purchase events update it and invalidate this
/// provider.
final class IsPremiumProvider extends $AsyncNotifierProvider<IsPremium, bool> {
  /// Whether the user is entitled to the premium features
  /// (ad removal and the home screen widget).
  ///
  /// keepAlive because this gates ad loading app-wide and must not be
  /// disposed and re-fetched between page navigations. The source of truth
  /// is the local database; purchase events update it and invalidate this
  /// provider.
  const IsPremiumProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isPremiumProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isPremiumHash();

  @$internal
  @override
  IsPremium create() => IsPremium();
}

String _$isPremiumHash() => r'18f7ea94850024be33e58126f057a8fc3b2343a7';

/// Whether the user is entitled to the premium features
/// (ad removal and the home screen widget).
///
/// keepAlive because this gates ad loading app-wide and must not be
/// disposed and re-fetched between page navigations. The source of truth
/// is the local database; purchase events update it and invalidate this
/// provider.

abstract class _$IsPremium extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
