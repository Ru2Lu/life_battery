import 'package:life_battery/src/features/purchases/data/entitlements_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_premium_provider.g.dart';

/// Whether the user is entitled to the premium features
/// (ad removal and the home screen widget).
///
/// keepAlive because this gates ad loading app-wide and must not be
/// disposed and re-fetched between page navigations. The source of truth
/// is the local database; purchase events update it and invalidate this
/// provider.
@Riverpod(keepAlive: true)
class IsPremium extends _$IsPremium {
  @override
  Future<bool> build() {
    return ref.watch(entitlementsRepositoryProvider).isPremium();
  }
}
