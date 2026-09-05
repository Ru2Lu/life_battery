import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/premium_purchase_status.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_premium_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/premium_product_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/purchase_updates_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/five_star_rating.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/premium_feature_list.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/premium_price_card.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

/// A modal sheet that starts the purchase of the premium product.
class PremiumBottomSheet extends ConsumerWidget {
  const PremiumBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showCupertinoSheet<void>(
      context: context,
      builder: (_) => const PremiumBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    // Closes the sheet once the entitlement is granted so the settings
    // page behind it shows the purchased state.
    ref.listen(purchaseUpdatesProvider, (_, status) {
      if (status == PremiumPurchaseStatus.purchased ||
          status == PremiumPurchaseStatus.restored) {
        Navigator.of(context).pop();
      }
    });

    final productAsyncValue = ref.watch(premiumProductProvider);
    final product = productAsyncValue.value;
    final isPremium = ref.watch(isPremiumProvider).value ?? false;

    // The Cupertino sheet route draws no background of its own.
    return Material(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                      child: Text(
                        l10n.premiumSheetTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const FiveStarRating(),
                    const SizedBox(height: 32),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: PremiumFeatureList(),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: switch (productAsyncValue) {
                        AsyncValue(value: final ProductDetails details) =>
                          PremiumPriceCard(price: details.price),
                        AsyncValue(isLoading: true) => const PriceCardFrame(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        // The store is unavailable or the product could not
                        // be fetched.
                        AsyncValue() => PriceCardFrame(
                          child: Text(
                            l10n.storeUnavailableContent,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                  foregroundColor: Theme.of(
                    context,
                  ).colorScheme.onInverseSurface,
                  minimumSize: const Size.fromHeight(56),
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: product == null || isPremium
                    ? null
                    : () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final isRequested = await ref
                            .read(purchasesRepositoryProvider)
                            .buyPremium(product: product);
                        if (!isRequested) {
                          messenger.showSnackBar(
                            SnackBar(content: Text(l10n.purchaseErrorContent)),
                          );
                        }
                      },
                child: Text(
                  isPremium
                      ? l10n.premiumPurchasedLabel
                      : l10n.purchaseButtonLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
