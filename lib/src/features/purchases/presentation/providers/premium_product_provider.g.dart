// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The premium product details, or null when the store is unavailable
/// or the product is not registered.

@ProviderFor(premiumProduct)
const premiumProductProvider = PremiumProductProvider._();

/// The premium product details, or null when the store is unavailable
/// or the product is not registered.

final class PremiumProductProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProductDetails?>,
          ProductDetails?,
          FutureOr<ProductDetails?>
        >
    with $FutureModifier<ProductDetails?>, $FutureProvider<ProductDetails?> {
  /// The premium product details, or null when the store is unavailable
  /// or the product is not registered.
  const PremiumProductProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumProductProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumProductHash();

  @$internal
  @override
  $FutureProviderElement<ProductDetails?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ProductDetails?> create(Ref ref) {
    return premiumProduct(ref);
  }
}

String _$premiumProductHash() => r'610be850349e1a56dc3a0301dbb513deed8b061b';
