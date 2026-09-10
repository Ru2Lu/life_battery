// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The premium plan products, or null when the store is unavailable.

@ProviderFor(premiumProducts)
const premiumProductsProvider = PremiumProductsProvider._();

/// The premium plan products, or null when the store is unavailable.

final class PremiumProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PremiumProducts?>,
          PremiumProducts?,
          FutureOr<PremiumProducts?>
        >
    with $FutureModifier<PremiumProducts?>, $FutureProvider<PremiumProducts?> {
  /// The premium plan products, or null when the store is unavailable.
  const PremiumProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumProductsHash();

  @$internal
  @override
  $FutureProviderElement<PremiumProducts?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PremiumProducts?> create(Ref ref) {
    return premiumProducts(ref);
  }
}

String _$premiumProductsHash() => r'13a8a34da74a4b85fa7885cfc61d25e2af6be120';
