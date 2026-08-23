// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(purchasesApiDataSource)
const purchasesApiDataSourceProvider = PurchasesApiDataSourceProvider._();

final class PurchasesApiDataSourceProvider
    extends
        $FunctionalProvider<
          PurchasesApiDataSource,
          PurchasesApiDataSource,
          PurchasesApiDataSource
        >
    with $Provider<PurchasesApiDataSource> {
  const PurchasesApiDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchasesApiDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchasesApiDataSourceHash();

  @$internal
  @override
  $ProviderElement<PurchasesApiDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PurchasesApiDataSource create(Ref ref) {
    return purchasesApiDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchasesApiDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchasesApiDataSource>(value),
    );
  }
}

String _$purchasesApiDataSourceHash() =>
    r'26808affdbbf66de77f8a9893c91e7cc68e3d659';

@ProviderFor(purchasesRepository)
const purchasesRepositoryProvider = PurchasesRepositoryProvider._();

final class PurchasesRepositoryProvider
    extends
        $FunctionalProvider<
          PurchasesRepository,
          PurchasesRepository,
          PurchasesRepository
        >
    with $Provider<PurchasesRepository> {
  const PurchasesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchasesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchasesRepositoryHash();

  @$internal
  @override
  $ProviderElement<PurchasesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PurchasesRepository create(Ref ref) {
    return purchasesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchasesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchasesRepository>(value),
    );
  }
}

String _$purchasesRepositoryHash() =>
    r'1eb41ac27ba9099599052da4b49de4e1d70b78ab';
