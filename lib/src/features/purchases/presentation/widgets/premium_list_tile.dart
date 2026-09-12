import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/common_widgets/async_value_widget.dart';
import 'package:life_battery/src/features/purchases/domain/paywall_source.dart';
import 'package:life_battery/src/features/purchases/domain/premium_purchase_status.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_premium_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/purchase_updates_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/premium_bottom_sheet.dart';
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
            onTap: () => PremiumBottomSheet.show(
              context,
              source: PaywallSource.settings,
            ),
          );
        }

        return _PremiumTile(
          subtitle: l10n.premiumDescriptionContent,
          onTap: () => PremiumBottomSheet.show(
            context,
            source: PaywallSource.settings,
          ),
        );
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
