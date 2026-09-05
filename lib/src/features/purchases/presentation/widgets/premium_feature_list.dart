import 'package:flutter/material.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

/// The features unlocked by the premium purchase.
class PremiumFeatureList extends StatelessWidget {
  const PremiumFeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.premiumFeatureListTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        _FeatureRow(
          icon: Icons.block,
          color: Colors.red.shade400,
          label: l10n.premiumFeatureAdRemovalLabel,
          emphasis: l10n.premiumFeatureAdRemovalEmphasis,
        ),
        const SizedBox(height: 16),
        _FeatureRow(
          icon: Icons.widgets,
          color: Theme.of(context).colorScheme.primary,
          label: l10n.premiumFeatureWidgetLabel,
          emphasis: l10n.premiumFeatureWidgetEmphasis,
        ),
      ],
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.emphasis,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String emphasis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = theme.textTheme.bodyLarge?.copyWith(
      fontSize: 18,
      color: theme.colorScheme.secondary,
    );
    final emphasisStyle = baseStyle?.copyWith(
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );

    final start = label.indexOf(emphasis);
    final spans = start < 0
        ? [TextSpan(text: label)]
        : [
            TextSpan(text: label.substring(0, start)),
            TextSpan(text: emphasis, style: emphasisStyle),
            TextSpan(text: label.substring(start + emphasis.length)),
          ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: color,
          child: Icon(icon, size: 18, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Text.rich(TextSpan(style: baseStyle, children: spans)),
      ],
    );
  }
}
