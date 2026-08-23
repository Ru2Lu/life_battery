import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

/// Stays enabled even after the purchase so that a reinstalled device can
/// always recover the entitlement.
class RestorePurchasesListTile extends ConsumerWidget {
  const RestorePurchasesListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: const Icon(Icons.restore),
      title: Text(
        l10n.restorePurchasesLabel,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.restoreRequestedContent)),
        );
        await ref.read(purchasesRepositoryProvider).restorePurchases();
      },
    );
  }
}
