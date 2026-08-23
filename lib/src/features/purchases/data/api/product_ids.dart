/// Provides the in-app purchase product IDs.
///
/// The same IDs are registered on both the App Store and Google Play.
abstract final class ProductIds {
  /// One-time purchase that unlocks all premium features
  /// (ad removal and the home screen widget).
  static const premiumLifetime = 'premium_lifetime';

  static const all = <String>{premiumLifetime};
}
