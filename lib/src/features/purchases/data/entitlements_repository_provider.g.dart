// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlements_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(entitlementsLocalDataSource)
const entitlementsLocalDataSourceProvider =
    EntitlementsLocalDataSourceProvider._();

final class EntitlementsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          EntitlementsLocalDataSource,
          EntitlementsLocalDataSource,
          EntitlementsLocalDataSource
        >
    with $Provider<EntitlementsLocalDataSource> {
  const EntitlementsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entitlementsLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entitlementsLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<EntitlementsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EntitlementsLocalDataSource create(Ref ref) {
    return entitlementsLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntitlementsLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntitlementsLocalDataSource>(value),
    );
  }
}

String _$entitlementsLocalDataSourceHash() =>
    r'97198fe00d2bbf5a0869894553ce39dca8d57036';

@ProviderFor(entitlementsRepository)
const entitlementsRepositoryProvider = EntitlementsRepositoryProvider._();

final class EntitlementsRepositoryProvider
    extends
        $FunctionalProvider<
          EntitlementsRepository,
          EntitlementsRepository,
          EntitlementsRepository
        >
    with $Provider<EntitlementsRepository> {
  const EntitlementsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entitlementsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entitlementsRepositoryHash();

  @$internal
  @override
  $ProviderElement<EntitlementsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EntitlementsRepository create(Ref ref) {
    return entitlementsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntitlementsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntitlementsRepository>(value),
    );
  }
}

String _$entitlementsRepositoryHash() =>
    r'01404041be6c6cc5918aa48cf6ce692922ba3235';
