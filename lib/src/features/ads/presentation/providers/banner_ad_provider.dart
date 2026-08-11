import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:life_battery/src/features/ads/data/banner_ad_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_ad_provider.g.dart';

@riverpod
Future<BannerAd?> bannerAd(Ref ref, {required int width}) async {
  // Registered before any await because ref cannot be used after disposal.
  // Disposes the ad loaded below when this provider is disposed.
  BannerAd? loadedAd;
  var isDisposed = false;
  ref.onDispose(() {
    isDisposed = true;
    unawaited(loadedAd?.dispose());
  });

  final repository = await ref.watch(bannerAdRepositoryProvider.future);
  final ad = await repository.loadBanner(width: width);

  // Ad loading cannot be cancelled, so when this provider was disposed
  // during the awaits above the ad arrives with no owner and onDispose has
  // already run. Dispose it here to release the native ad resources.
  if (isDisposed) {
    unawaited(ad?.dispose());
    return null;
  }
  loadedAd = ad;
  return ad;
}
