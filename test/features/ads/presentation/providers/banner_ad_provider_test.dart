import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/ads/data/api/banner_ad_api_data_source.dart';
import 'package:life_battery/src/features/ads/data/banner_ad_repository_provider.dart';
import 'package:life_battery/src/features/ads/presentation/providers/banner_ad_provider.dart';
import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';

import '../../../../../test_helpers/fake_entitlements.dart';

class FakeBannerAdApiDataSource implements BannerAdApiDataSource {
  int initializeCallCount = 0;
  int loadBannerCallCount = 0;

  @override
  Future<void> initialize() async {
    initializeCallCount++;
  }

  @override
  Future<BannerAd?> loadBanner({required int width}) async {
    loadBannerCallCount++;
    return null;
  }
}

void main() {
  late FakeBannerAdApiDataSource fakeAds;

  ProviderContainer buildContainer({required bool hasRemovedAds}) {
    fakeAds = FakeBannerAdApiDataSource();
    final container = ProviderContainer(
      overrides: [
        bannerAdApiDataSourceProvider.overrideWithValue(fakeAds),
        entitlementsLocalDataSourceProvider.overrideWithValue(
          FakeEntitlementsLocalDataSource(hasRemovedAds: hasRemovedAds),
        ),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('Does not initialize the SDK or load an ad when ad-free', () async {
    final container = buildContainer(hasRemovedAds: true);

    final ad = await container.read(bannerAdProvider(width: 320).future);

    expect(ad, isNull);
    expect(fakeAds.initializeCallCount, 0);
    expect(fakeAds.loadBannerCallCount, 0);
  });

  test('Loads an ad when not ad-free', () async {
    final container = buildContainer(hasRemovedAds: false);

    await container.read(bannerAdProvider(width: 320).future);

    expect(fakeAds.initializeCallCount, 1);
    expect(fakeAds.loadBannerCallCount, 1);
  });
}
