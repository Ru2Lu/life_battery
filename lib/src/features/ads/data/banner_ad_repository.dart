import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:life_battery/src/features/ads/data/api/banner_ad_api_data_source.dart';

class BannerAdRepository {
  const BannerAdRepository({required BannerAdApiDataSource apiDataSource})
    : _apiDataSource = apiDataSource;

  final BannerAdApiDataSource _apiDataSource;

  Future<void> initialize() {
    return _apiDataSource.initialize();
  }

  Future<BannerAd?> loadBanner({required int width}) {
    return _apiDataSource.loadBanner(width: width);
  }
}
