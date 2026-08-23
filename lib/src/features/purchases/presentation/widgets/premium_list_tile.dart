import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/common_widgets/async_value_widget.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/premium_purchase_status.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_premium_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/premium_product_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/purchase_updates_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

class PremiumListTile extends ConsumerWidget {
  const PremiumListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen(purchaseUpdatesProvider, (_, status) {
      final message = switch (status) {
        PremiumPurchaseStatus.purchased ||
        PremiumPurchaseStatus.restored => l10n.purchaseSuccessContent,
        PremiumPurchaseStatus.pending => l10n.purchasePendingContent,
        PremiumPurchaseStatus.error => l10n.purchaseErrorContent,
        PremiumPurchaseStatus.canceled || PremiumPurchaseStatus.none => null,
      };
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    });

    final isPremium = ref.watch(isPremiumProvider);

    return AsyncValueWidget(
      asyncValue: isPremium,
      data: (premium) {
        if (premium) {
          return _PremiumTile(
            trailingText: l10n.premiumPurchasedLabel,
            trailingIcon: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        final product = ref.watch(premiumProductProvider);
        return switch (product) {
          AsyncValue(value: final ProductDetails productDetails) =>
            _PremiumTile(
              subtitle: l10n.premiumDescriptionContent,
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                final isRequested = await ref
                    .read(purchasesRepositoryProvider)
                    .buyPremium(product: productDetails);
                if (!isRequested) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(l10n.purchaseErrorContent)),
                  );
                }
              },
            ),
          AsyncValue(isLoading: true) => _PremiumTile(
            subtitle: l10n.premiumDescriptionContent,
          ),
          // The store is unavailable or the product could not be fetched.
          AsyncValue() => _PremiumTile(
            subtitle: l10n.storeUnavailableContent,
          ),
        };
      },
    );
  }
}

class _PremiumTile extends StatelessWidget {
  const _PremiumTile({
    this.trailingText,
    this.trailingIcon,
    this.subtitle,
    this.onTap,
  });

  final String? trailingText;
  final Icon? trailingIcon;
  final String? subtitle;
  final Future<void> Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: const Icon(Icons.workspace_premium_outlined),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.premiumLabel,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (trailingText != null)
            Text(
              trailingText!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
        ],
      ),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: trailingIcon,
      onTap: onTap,
    );
  }
}
