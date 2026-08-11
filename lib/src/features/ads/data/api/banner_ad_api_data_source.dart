import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract interface class BannerAdApiDataSource {
  Future<void> initialize();

  Future<BannerAd?> loadBanner({required int width});
}
