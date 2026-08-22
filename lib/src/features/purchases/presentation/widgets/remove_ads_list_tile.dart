import 'package:flutter/material.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

class RemoveAdsListTile extends StatelessWidget {
  const RemoveAdsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: const Icon(Icons.block_outlined),
      title: Text(
        l10n.removeAdsLabel,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
