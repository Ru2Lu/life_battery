import 'package:life_battery/src/features/ads/data/api/banner_ad_api_data_source.dart';
import 'package:life_battery/src/features/ads/data/api/google_mobile_ads_banner_ad_api_data_source.dart';
import 'package:life_battery/src/features/ads/data/banner_ad_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_ad_repository_provider.g.dart';

@Riverpod(keepAlive: true)
BannerAdApiDataSource bannerAdApiDataSource(Ref ref) {
  return GoogleMobileAdsBannerAdApiDataSource();
}

@Riverpod(keepAlive: true)
Future<BannerAdRepository> bannerAdRepository(Ref ref) async {
  final apiDataSource = ref.watch(bannerAdApiDataSourceProvider);
  final repository = BannerAdRepository(apiDataSource: apiDataSource);
  await repository.initialize();
  return repository;
}
