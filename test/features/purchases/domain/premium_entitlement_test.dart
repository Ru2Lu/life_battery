import 'package:flutter_test/flutter_test.dart';
import 'package:life_battery/src/features/purchases/domain/premium_entitlement.dart';

void main() {
  final now = DateTime(2026, 9, 6);

  test('No purchase is never active', () {
    const entitlement = PremiumEntitlement.none();

    expect(entitlement.isActive(now), isFalse);
  });

  test('Lifetime purchase is always active', () {
    const entitlement = PremiumEntitlement(hasLifetime: true);

    expect(entitlement.isActive(now), isTrue);
  });

  test('Subscription is active before its expiry', () {
    final entitlement = PremiumEntitlement(
      hasLifetime: false,
      subscriptionExpiresAt: now.add(const Duration(days: 1)),
    );

    expect(entitlement.isActive(now), isTrue);
  });

  test('Subscription is inactive at and after its expiry', () {
    final entitlement = PremiumEntitlement(
      hasLifetime: false,
      subscriptionExpiresAt: now,
    );

    expect(entitlement.isActive(now), isFalse);
    expect(entitlement.isActive(now.add(const Duration(days: 1))), isFalse);
  });

  test('Lifetime purchase stays active after the subscription expired', () {
    final entitlement = PremiumEntitlement(
      hasLifetime: true,
      subscriptionExpiresAt: now.subtract(const Duration(days: 1)),
    );

    expect(entitlement.isActive(now), isTrue);
  });
}
