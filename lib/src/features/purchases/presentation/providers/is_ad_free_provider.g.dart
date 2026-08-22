// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_ad_free_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the user is entitled to an ad-free experience.
///
/// keepAlive because this gates ad loading app-wide and must not be
/// disposed and re-fetched between page navigations. The source of truth
/// is the local database; purchase events update it and invalidate this
/// provider.

@ProviderFor(IsAdFree)
const isAdFreeProvider = IsAdFreeProvider._();

/// Whether the user is entitled to an ad-free experience.
///
/// keepAlive because this gates ad loading app-wide and must not be
/// disposed and re-fetched between page navigations. The source of truth
/// is the local database; purchase events update it and invalidate this
/// provider.
final class IsAdFreeProvider extends $AsyncNotifierProvider<IsAdFree, bool> {
  /// Whether the user is entitled to an ad-free experience.
  ///
  /// keepAlive because this gates ad loading app-wide and must not be
  /// disposed and re-fetched between page navigations. The source of truth
  /// is the local database; purchase events update it and invalidate this
  /// provider.
  const IsAdFreeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAdFreeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAdFreeHash();

  @$internal
  @override
  IsAdFree create() => IsAdFree();
}

String _$isAdFreeHash() => r'64036fca7949dc3afa4662cb372e6b2f246afc94';

/// Whether the user is entitled to an ad-free experience.
///
/// keepAlive because this gates ad loading app-wide and must not be
/// disposed and re-fetched between page navigations. The source of truth
/// is the local database; purchase events update it and invalidate this
/// provider.

abstract class _$IsAdFree extends $AsyncNotifier<bool> {
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
