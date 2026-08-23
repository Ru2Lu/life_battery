// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_ad_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bannerAd)
const bannerAdProvider = BannerAdFamily._();

final class BannerAdProvider
    extends
        $FunctionalProvider<
          AsyncValue<BannerAd?>,
          BannerAd?,
          FutureOr<BannerAd?>
        >
    with $FutureModifier<BannerAd?>, $FutureProvider<BannerAd?> {
  const BannerAdProvider._({
    required BannerAdFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'bannerAdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bannerAdHash();

  @override
  String toString() {
    return r'bannerAdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BannerAd?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<BannerAd?> create(Ref ref) {
    final argument = this.argument as int;
    return bannerAd(ref, width: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BannerAdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bannerAdHash() => r'6a0dabdaa12039d065bd04d92e8958cfc6c29e2b';

final class BannerAdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BannerAd?>, int> {
  const BannerAdFamily._()
    : super(
        retry: null,
        name: r'bannerAdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BannerAdProvider call({required int width}) =>
      BannerAdProvider._(argument: width, from: this);

  @override
  String toString() => r'bannerAdProvider';
}
