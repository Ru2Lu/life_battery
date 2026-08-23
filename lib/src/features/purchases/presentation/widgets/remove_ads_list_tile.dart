import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:life_battery/src/common_widgets/async_value_widget.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/features/purchases/domain/remove_ads_purchase_status.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_ad_free_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/purchase_updates_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/remove_ads_product_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

class RemoveAdsListTile extends ConsumerWidget {
  const RemoveAdsListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen(purchaseUpdatesProvider, (_, status) {
      final message = switch (status) {
        RemoveAdsPurchaseStatus.purchased ||
        RemoveAdsPurchaseStatus.restored => l10n.purchaseSuccessContent,
        RemoveAdsPurchaseStatus.pending => l10n.purchasePendingContent,
        RemoveAdsPurchaseStatus.error => l10n.purchaseErrorContent,
        RemoveAdsPurchaseStatus.canceled ||
        RemoveAdsPurchaseStatus.none => null,
      };
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    });

    final isAdFree = ref.watch(isAdFreeProvider);

    return AsyncValueWidget(
      asyncValue: isAdFree,
      data: (adFree) {
        if (adFree) {
          return _RemoveAdsTile(
            trailingText: l10n.removeAdsPurchasedLabel,
            trailingIcon: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        }

        final product = ref.watch(removeAdsProductProvider);
        return switch (product) {
          AsyncValue(value: final ProductDetails productDetails) =>
            _RemoveAdsTile(
              // The price string comes from the store already formatted for
              // the user's locale and currency.
              trailingText: productDetails.price,
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                final isRequested = await ref
                    .read(purchasesRepositoryProvider)
                    .buyRemoveAds(product: productDetails);
                if (!isRequested) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(l10n.purchaseErrorContent)),
                  );
                }
              },
            ),
          AsyncValue(isLoading: true) => const _RemoveAdsTile(),
          // The store is unavailable or the product could not be fetched.
          AsyncValue() => _RemoveAdsTile(
            subtitle: l10n.storeUnavailableContent,
          ),
        };
      },
    );
  }
}

class _RemoveAdsTile extends StatelessWidget {
  const _RemoveAdsTile({
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
      leading: const Icon(Icons.block_outlined),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.removeAdsLabel,
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
