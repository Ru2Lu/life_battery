import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';

class ReviewAppListTile extends ConsumerWidget {
  const ReviewAppListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: const Icon(Icons.favorite_outline),
      title: Text(
        l10n.reviewAppLabel,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () async {
        unawaited(ref.read(analyticsRepositoryProvider).logReviewTap());

        final inAppReview = InAppReview.instance;
        if (Platform.isIOS) {
          await inAppReview.openStoreListing(appStoreId: '6449723058');
        } else if (Platform.isAndroid) {
          await inAppReview.openStoreListing();
        }
      },
    );
  }
}
