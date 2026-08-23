// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_ads_product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The remove_ads product details, or null when the store is unavailable
/// or the product is not registered.

@ProviderFor(removeAdsProduct)
const removeAdsProductProvider = RemoveAdsProductProvider._();

/// The remove_ads product details, or null when the store is unavailable
/// or the product is not registered.

final class RemoveAdsProductProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProductDetails?>,
          ProductDetails?,
          FutureOr<ProductDetails?>
        >
    with $FutureModifier<ProductDetails?>, $FutureProvider<ProductDetails?> {
  /// The remove_ads product details, or null when the store is unavailable
  /// or the product is not registered.
  const RemoveAdsProductProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'removeAdsProductProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$removeAdsProductHash();

  @$internal
  @override
  $FutureProviderElement<ProductDetails?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ProductDetails?> create(Ref ref) {
    return removeAdsProduct(ref);
  }
}

String _$removeAdsProductHash() => r'9589a580a6950ba8fcfa11a4631bd6261e381a18';
