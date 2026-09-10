import 'package:flutter/material.dart';
import 'package:life_battery/src/features/purchases/domain/premium_plan.dart';
import 'package:life_battery/src/features/purchases/domain/premium_products.dart';
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

/// An outlined card with the plan tabs and the selected plan's price.
class PremiumPriceCard extends StatelessWidget {
  const PremiumPriceCard({
    required this.products,
    required this.offer,
    required this.onPlanChanged,
    super.key,
  });

  final PremiumProducts products;

  final PremiumOffer offer;

  final ValueChanged<PremiumPlan> onPlanChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final product = offer.product;

    final (price, description) = switch (offer.plan) {
      PremiumPlan.monthly => (
        l10n.monthlyPriceLabel(product.price),
        l10n.monthlySubscriptionDescription,
      ),
      PremiumPlan.lifetime => (
        product.price,
        l10n.oneTimePurchaseDescription,
      ),
    };

    return PriceCardFrame(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (final plan in products.availablePlans) ...[
                _PlanTab(
                  label: switch (plan) {
                    PremiumPlan.monthly => l10n.monthlyPlanLabel,
                    PremiumPlan.lifetime => l10n.oneTimePurchaseLabel,
                  },
                  isSelected: plan == offer.plan,
                  onTap: () => onPlanChanged(plan),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Text(
            price,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanTab extends StatelessWidget {
  const _PlanTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.inverseSurface : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: isSelected
                ? theme.colorScheme.onInverseSurface
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
