import 'package:flutter/material.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

/// The outlined rounded frame shared by the price card states.
class PriceCardFrame extends StatelessWidget {
  const PriceCardFrame({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }
}

/// An outlined card showing the one-time purchase badge and the store price.
class PremiumPriceCard extends StatelessWidget {
  const PremiumPriceCard({required this.price, super.key});

  /// The localized price string returned by the store.
  final String price;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return PriceCardFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.inverseSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              l10n.oneTimePurchaseLabel,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onInverseSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.oneTimePurchaseDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
