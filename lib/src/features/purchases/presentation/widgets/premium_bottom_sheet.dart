import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
class PremiumBottomSheet extends HookConsumerWidget {
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
    final purchaseError = useState<String?>(null);
    final isPurchasing = useState(false);

    // Closes the sheet once the entitlement is granted so the settings
    // page behind it shows the purchased state. A failed purchase surfaces
    // inline above the purchase button.
    ref.listen(purchaseUpdatesProvider, (_, status) {
      switch (status) {
        case PremiumPurchaseStatus.purchased || PremiumPurchaseStatus.restored:
          Navigator.of(context).pop();
        case PremiumPurchaseStatus.error:
          purchaseError.value = l10n.purchaseErrorContent;
        case PremiumPurchaseStatus.pending ||
            PremiumPurchaseStatus.canceled ||
            PremiumPurchaseStatus.none:
          break;
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
                        AsyncValue(isLoading: true) => PriceCardFrame(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
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
            if (purchaseError.value != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  purchaseError.value!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                onPressed: product == null || isPremium || isPurchasing.value
                    ? null
                    : () async {
                        purchaseError.value = null;
                        isPurchasing.value = true;
                        try {
                          final isRequested = await ref
                              .read(purchasesRepositoryProvider)
                              .buyPremium(product: product);
                          if (!isRequested && context.mounted) {
                            purchaseError.value = l10n.purchaseErrorContent;
                          }
                        } finally {
                          if (context.mounted) {
                            isPurchasing.value = false;
                          }
                        }
                      },
                child: isPurchasing.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      )
                    : Text(
                        isPremium
                            ? l10n.premiumPurchasedLabel
                            : l10n.purchaseButtonLabel,
                      ),
              ),
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: _RestoreButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RestoreButton extends HookConsumerWidget {
  const _RestoreButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isRestoring = useState(false);

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: isRestoring.value
          ? null
          : () async {
              isRestoring.value = true;
              try {
                await ref.read(purchasesRepositoryProvider).restorePurchases();
              } finally {
                if (context.mounted) {
                  isRestoring.value = false;
                }
              }
            },
      child: isRestoring.value
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          : Text(l10n.restorePurchasesLabel),
    );
  }
}
