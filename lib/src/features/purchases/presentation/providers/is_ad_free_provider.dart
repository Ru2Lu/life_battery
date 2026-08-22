import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_ad_free_provider.g.dart';

/// Whether the user is entitled to an ad-free experience.
///
/// keepAlive because this gates ad loading app-wide and must not be
/// disposed and re-fetched between page navigations. The source of truth
/// is the local database; purchase events update it and invalidate this
/// provider.
@Riverpod(keepAlive: true)
class IsAdFree extends _$IsAdFree {
  @override
  Future<bool> build() {
    return ref.watch(entitlementsRepositoryProvider).isAdFree();
  }
}
