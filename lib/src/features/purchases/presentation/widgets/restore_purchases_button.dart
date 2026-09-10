import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/purchases/data/purchases_repository_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

/// Asks the store to redeliver past purchases, showing an inline
/// progress indicator while the restore is in flight.
class RestorePurchasesButton extends HookConsumerWidget {
  const RestorePurchasesButton({super.key});

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
