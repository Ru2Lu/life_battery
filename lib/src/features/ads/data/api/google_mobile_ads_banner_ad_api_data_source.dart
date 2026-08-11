import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:life_battery/src/features/ads/data/api/ad_unit_ids.dart';
import 'package:life_battery/src/features/ads/data/api/banner_ad_api_data_source.dart';

class GoogleMobileAdsBannerAdApiDataSource implements BannerAdApiDataSource {
  @override
  Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }

  @override
  Future<BannerAd?> loadBanner({required int width}) async {
    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    if (size == null) return null;

    final completer = Completer<BannerAd?>();
    final bannerAd = BannerAd(
      adUnitId: AdUnitIds.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => completer.complete(ad as BannerAd),
        onAdFailedToLoad: (ad, error) {
          unawaited(ad.dispose());
          completer.complete(null);
        },
      ),
    );
    await bannerAd.load();
    return completer.future;
  }
}
