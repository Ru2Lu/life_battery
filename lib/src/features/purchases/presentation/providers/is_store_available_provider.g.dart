// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_store_available_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the store is available on this device.

@ProviderFor(isStoreAvailable)
const isStoreAvailableProvider = IsStoreAvailableProvider._();

/// Whether the store is available on this device.

final class IsStoreAvailableProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Whether the store is available on this device.
  const IsStoreAvailableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isStoreAvailableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isStoreAvailableHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return isStoreAvailable(ref);
  }
}

String _$isStoreAvailableHash() => r'9b2574ea0181037e49c8523ca358bc8bfc350edd';
