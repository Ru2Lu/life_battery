// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(analyticsApiDataSource)
const analyticsApiDataSourceProvider = AnalyticsApiDataSourceProvider._();

final class AnalyticsApiDataSourceProvider
    extends
        $FunctionalProvider<
          AnalyticsApiDataSource,
          AnalyticsApiDataSource,
          AnalyticsApiDataSource
        >
    with $Provider<AnalyticsApiDataSource> {
  const AnalyticsApiDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsApiDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsApiDataSourceHash();

  @$internal
  @override
  $ProviderElement<AnalyticsApiDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnalyticsApiDataSource create(Ref ref) {
    return analyticsApiDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsApiDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsApiDataSource>(value),
    );
  }
}

String _$analyticsApiDataSourceHash() =>
    r'f58fc20b7e3c84eeb6de89e1520d8aef052a99bc';

@ProviderFor(analyticsRepository)
const analyticsRepositoryProvider = AnalyticsRepositoryProvider._();

final class AnalyticsRepositoryProvider
    extends
        $FunctionalProvider<
          AnalyticsRepository,
          AnalyticsRepository,
          AnalyticsRepository
        >
    with $Provider<AnalyticsRepository> {
  const AnalyticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AnalyticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnalyticsRepository create(Ref ref) {
    return analyticsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsRepository>(value),
    );
  }
}

String _$analyticsRepositoryHash() =>
    r'f7d353d82e9ba7bd5ad748d716f34fedd89505af';
