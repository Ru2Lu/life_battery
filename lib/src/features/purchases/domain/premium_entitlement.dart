/// The stored premium entitlement.
///
/// The lifetime purchase and the subscription are tracked independently;
/// either one grants the premium features.
class PremiumEntitlement {
  const PremiumEntitlement({
    required this.hasLifetime,
    this.subscriptionExpiresAt,
  });

  const PremiumEntitlement.none() : this(hasLifetime: false);

  /// Whether the one-time lifetime purchase was made.
  final bool hasLifetime;

  /// Locally estimated expiry of the latest known subscription renewal;
  /// null when the user never subscribed.
  final DateTime? subscriptionExpiresAt;

  /// Whether the entitlement grants premium at [now].
  bool isActive(DateTime now) {
    if (hasLifetime) return true;
    final expiresAt = subscriptionExpiresAt;
    return expiresAt != null && now.isBefore(expiresAt);
  }
}
