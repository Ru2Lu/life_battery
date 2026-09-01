import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

/// A five-star rating flanked by laurel branches.
class FiveStarRating extends StatelessWidget {
  const FiveStarRating({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _Laurel(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                l10n.fiveStarsLabel,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const _FiveStars(),
            ],
          ),
        ),
        const _Laurel(isMirrored: true),
      ],
    );
  }
}

class _FiveStars extends StatelessWidget {
  const _FiveStars();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          Icon(
            Icons.star,
            color: Colors.orange.shade600,
            size: 28,
          ),
      ],
    );
  }
}

class _Laurel extends StatelessWidget {
  const _Laurel({this.isMirrored = false});

  final bool isMirrored;

  @override
  Widget build(BuildContext context) {
    final laurel = SvgPicture.asset(
      'assets/images/laurel_leading.svg',
      height: 72,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.secondary,
        BlendMode.srcIn,
      ),
    );
    if (!isMirrored) return laurel;
    return Transform.flip(flipX: true, child: laurel);
  }
}
