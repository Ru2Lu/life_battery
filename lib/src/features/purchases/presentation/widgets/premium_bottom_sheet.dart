import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/premium_purchase_status.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/purchase_updates_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

/// A modal sheet that starts the purchase of [product].
class PremiumBottomSheet extends ConsumerWidget {
  const PremiumBottomSheet({required this.product, super.key});

  final ProductDetails product;

  static Future<void> show(
    BuildContext context, {
    required ProductDetails product,
  }) {
    return showCupertinoSheet<void>(
      context: context,
      builder: (_) => PremiumBottomSheet(product: product),
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

    // The Cupertino sheet route draws no background of its own.
    return Material(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
              child: Text(
                l10n.premiumSheetTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
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
                child: Text(l10n.purchaseButtonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
