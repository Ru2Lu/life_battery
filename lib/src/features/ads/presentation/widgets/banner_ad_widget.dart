import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/ads/presentation/providers/banner_ad_provider.dart';
import 'package:life_battery/src/features/purchases/domain/paywall_source.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/premium_bottom_sheet.dart';

class BannerAdWidget extends ConsumerWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width.truncate();
    final bannerAd = ref.watch(bannerAdProvider(width: width)).value;
    if (bannerAd == null) {
      return const SizedBox.shrink();
    }
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: bannerAd.size.width.toDouble(),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: _AdCloseButton(),
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: bannerAd.size.width.toDouble(),
            height: bannerAd.size.height.toDouble(),
            child: AdWidget(ad: bannerAd),
          ),
        ],
      ),
    );
  }
}

class _AdCloseButton extends StatelessWidget {
  const _AdCloseButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PremiumBottomSheet.show(
        context,
        source: PaywallSource.ad,
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inverseSurface,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close,
          size: 20,
          color: Theme.of(context).colorScheme.onInverseSurface,
        ),
      ),
    );
  }
}
