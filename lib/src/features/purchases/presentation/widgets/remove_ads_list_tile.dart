import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/common_widgets/async_value_widget.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_ad_free_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/is_store_available_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

class RemoveAdsListTile extends ConsumerWidget {
  const RemoveAdsListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final isAdFree = ref.watch(isAdFreeProvider);

    return AsyncValueWidget(
      asyncValue: isAdFree,
      data: (adFree) {
        final isStoreAvailable =
            ref.watch(isStoreAvailableProvider).value ?? true;

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
              if (adFree)
                Text(
                  l10n.removeAdsPurchasedLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
            ],
          ),
          subtitle: isStoreAvailable || adFree
              ? null
              : Text(l10n.storeUnavailableContent),
          trailing: adFree
              ? Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.primary,
                )
              : null,
        );
      },
    );
  }
}
