/// The payment plans that unlock the premium features.
///
/// The product IDs are registered on the App Store; Google Play does not
/// sell the premium purchase yet.
enum PremiumPlan {
  /// Monthly auto-renewable subscription.
  monthly('premium_monthly'),

  /// One-time lifetime purchase.
  lifetime('premium_lifetime')
  ;

  const PremiumPlan(this.productId);

  /// The store product ID for this plan.
  final String productId;

  static Set<String> get allProductIds =>
      values.map((plan) => plan.productId).toSet();
}
