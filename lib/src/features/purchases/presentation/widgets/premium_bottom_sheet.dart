import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository_provider.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/paywall_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';
import 'package:life_battery/src/features/purchases/domain/premium_products.dart';
import 'package:life_battery/src/features/purchases/domain/premium_purchase_status.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_premium_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/premium_products_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/purchase_updates_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/five_star_rating.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/premium_feature_list.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/premium_price_card.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/restore_purchases_button.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

/// A modal sheet that starts the purchase of the premium product.
class PremiumBottomSheet extends HookConsumerWidget {
  const PremiumBottomSheet({required this.source, super.key});

  /// Where the sheet was opened from, reported with the paywall_view event.
  final PaywallSource source;

  static Future<void> show(
    BuildContext context, {
    required PaywallSource source,
  }) {
    return showCupertinoSheet<void>(
      context: context,
      builder: (_) => PremiumBottomSheet(source: source),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final purchaseError = useState<String?>(null);
    final isPurchasing = useState(false);

    useEffect(
      () {
        unawaited(
          ref.read(analyticsRepositoryProvider).logPaywallView(source: source),
        );
        return null;
      },
      const [],
    );

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

    final selectedPlan = useState(PremiumPlan.lifetime);
    final productsAsyncValue = ref.watch(premiumProductsProvider);
    final offer = productsAsyncValue.value?.resolve(selectedPlan.value);
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
                      child: switch (productsAsyncValue) {
                        AsyncValue(value: final PremiumProducts details)
                            when offer != null =>
                          PremiumPriceCard(
                            products: details,
                            offer: offer,
                            onPlanChanged: (plan) => selectedPlan.value = plan,
                          ),
                        AsyncValue(isLoading: true) => PriceCardFrame(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        // The store is unavailable or no product could
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
                onPressed: offer == null || isPremium || isPurchasing.value
                    ? null
                    : () async {
                        unawaited(
                          ref
                              .read(analyticsRepositoryProvider)
                              .logPurchaseStart(plan: selectedPlan.value),
                        );
                        ref
                            .read(purchaseUpdatesProvider.notifier)
                            .markPurchaseStarted();
                        purchaseError.value = null;
                        isPurchasing.value = true;
                        try {
                          final isRequested = await ref
                              .read(purchasesRepositoryProvider)
                              .buyPremium(product: offer.product);
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
              child: RestorePurchasesButton(),
            ),
          ],
        ),
      ),
    );
  }
}
