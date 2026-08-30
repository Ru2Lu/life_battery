// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get generalError => 'Error occurred.';

  @override
  String get birthDateLabel => 'Birth Date';

  @override
  String get idealLifespanLabel => 'Ideal Lifespan';

  @override
  String get ageUnit => 'years';

  @override
  String get dayUnit => 'd';

  @override
  String get reviewAppLabel => 'Rate this app';

  @override
  String get privacyPolicyLabel => 'Privacy policy';

  @override
  String get appearanceLabel => 'Appearance';

  @override
  String get systemLabel => 'System';

  @override
  String get lightLabel => 'Light';

  @override
  String get darkLabel => 'Dark';

  @override
  String get deleteAllLabel => 'Delete Data';

  @override
  String get deleteTitle => 'Delete All Data';

  @override
  String get deleteContent =>
      'Are you sure you want to delete the data?\nDeleted data cannot be restored.';

  @override
  String get cancelLabel => 'Cancel';

  @override
  String get deleteLabel => 'Delete';

  @override
  String get userDeletionSuccess =>
      'Your data has been successfully deleted.\nThank you for using our app.\nWe hope to see you again in the future.😊';

  @override
  String get notificationSettingsLabel => 'Notification settings';

  @override
  String notificationTitle(int percentage) {
    return '$percentage% of your life remaining.';
  }

  @override
  String get notificationBody =>
      'Let\'s make the next 1% your best chapter yet!';

  @override
  String get notificationBodyZeroPercent =>
      'Your story lives on within the stories of others.Thank you.';

  @override
  String get longPressToEditHint => 'Long press to edit your life';

  @override
  String get premiumLabel => 'Premium';

  @override
  String get premiumDescriptionContent =>
      'Removes ads and unlocks the home screen widget.';

  @override
  String get premiumPurchasedLabel => 'Purchased';

  @override
  String get premiumSheetTitle => 'Make the most of your time';

  @override
  String get purchaseButtonLabel => 'Purchase';

  @override
  String get storeUnavailableContent => 'The store is currently unavailable.';

  @override
  String get purchaseSuccessContent =>
      'Thank you! Premium features are now unlocked.';

  @override
  String get purchasePendingContent => 'Your purchase is pending approval.';

  @override
  String get purchaseErrorContent =>
      'The purchase could not be completed. Please try again.';

  @override
  String get restorePurchasesLabel => 'Restore purchases';

  @override
  String get restoreRequestedContent => 'Restoring purchases...';

  @override
  String get todaysMessageHint =>
      'This moment is the youngest you\'ll ever be.';
}
