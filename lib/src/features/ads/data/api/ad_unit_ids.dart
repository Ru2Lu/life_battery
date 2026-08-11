import 'package:flutter/foundation.dart';

/// Provides the AdMob ad unit ID for each platform.
abstract final class AdUnitIds {
  static const _androidBannerTestId = 'ca-app-pub-3940256099942544/6300978111';
  static const _iosBannerTestId = 'ca-app-pub-3940256099942544/2934735716';

  static const _androidBannerId = 'ca-app-pub-4961273691243921/8827561407';
  static const _iosBannerId = 'ca-app-pub-4961273691243921/7514479734';

  static String get banner {
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    // Debug builds always use Google's official test ad units so that
    // development never generates invalid traffic on the real ad units.
    if (kDebugMode) {
      return isAndroid ? _androidBannerTestId : _iosBannerTestId;
    }
    return isAndroid ? _androidBannerId : _iosBannerId;
  }
}
