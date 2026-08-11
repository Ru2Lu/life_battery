// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_ad_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bannerAdApiDataSource)
const bannerAdApiDataSourceProvider = BannerAdApiDataSourceProvider._();

final class BannerAdApiDataSourceProvider
    extends
        $FunctionalProvider<
          BannerAdApiDataSource,
          BannerAdApiDataSource,
          BannerAdApiDataSource
        >
    with $Provider<BannerAdApiDataSource> {
  const BannerAdApiDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannerAdApiDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannerAdApiDataSourceHash();

  @$internal
  @override
  $ProviderElement<BannerAdApiDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BannerAdApiDataSource create(Ref ref) {
    return bannerAdApiDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BannerAdApiDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BannerAdApiDataSource>(value),
    );
  }
}

String _$bannerAdApiDataSourceHash() =>
    r'5c2e2e082d6d7dd102c6b9059876d115f672e319';

@ProviderFor(bannerAdRepository)
const bannerAdRepositoryProvider = BannerAdRepositoryProvider._();

final class BannerAdRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<BannerAdRepository>,
          BannerAdRepository,
          FutureOr<BannerAdRepository>
        >
    with
        $FutureModifier<BannerAdRepository>,
        $FutureProvider<BannerAdRepository> {
  const BannerAdRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannerAdRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannerAdRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<BannerAdRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BannerAdRepository> create(Ref ref) {
    return bannerAdRepository(ref);
  }
}

String _$bannerAdRepositoryHash() =>
    r'811f743abeaccbde4b6ac73817ccd721ba977559';
