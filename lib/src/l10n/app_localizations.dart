import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @generalError.
  ///
  /// In en, this message translates to:
  /// **'Error occurred.'**
  String get generalError;

  /// No description provided for @birthDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDateLabel;

  /// No description provided for @idealLifespanLabel.
  ///
  /// In en, this message translates to:
  /// **'Ideal Lifespan'**
  String get idealLifespanLabel;

  /// No description provided for @ageUnit.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get ageUnit;

  /// No description provided for @dayUnit.
  ///
  /// In en, this message translates to:
  /// **'d'**
  String get dayUnit;

  /// No description provided for @reviewAppLabel.
  ///
  /// In en, this message translates to:
  /// **'Rate this app'**
  String get reviewAppLabel;

  /// No description provided for @privacyPolicyLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicyLabel;

  /// No description provided for @appearanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceLabel;

  /// No description provided for @systemLabel.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemLabel;

  /// No description provided for @lightLabel.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightLabel;

  /// No description provided for @darkLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkLabel;

  /// No description provided for @deleteAllLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete Data'**
  String get deleteAllLabel;

  /// No description provided for @deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete All Data'**
  String get deleteTitle;

  /// No description provided for @deleteContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the data?\nDeleted data cannot be restored.'**
  String get deleteContent;

  /// No description provided for @cancelLabel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLabel;

  /// No description provided for @deleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteLabel;

  /// No description provided for @userDeletionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your data has been successfully deleted.\nThank you for using our app.\nWe hope to see you again in the future.😊'**
  String get userDeletionSuccess;

  /// No description provided for @notificationSettingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Notification settings'**
  String get notificationSettingsLabel;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% of your life remaining.'**
  String notificationTitle(int percentage);

  /// No description provided for @notificationBody.
  ///
  /// In en, this message translates to:
  /// **'Let\'s make the next 1% your best chapter yet!'**
  String get notificationBody;

  /// No description provided for @notificationBodyZeroPercent.
  ///
  /// In en, this message translates to:
  /// **'Your story lives on within the stories of others.Thank you.'**
  String get notificationBodyZeroPercent;

  /// No description provided for @longPressToEditHint.
  ///
  /// In en, this message translates to:
  /// **'Long press to edit your life'**
  String get longPressToEditHint;

  /// No description provided for @premiumLabel.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premiumLabel;

  /// No description provided for @premiumDescriptionContent.
  ///
  /// In en, this message translates to:
  /// **'Removes ads and unlocks the home screen widget.'**
  String get premiumDescriptionContent;

  /// No description provided for @premiumPurchasedLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get premiumPurchasedLabel;

  /// No description provided for @premiumSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Make the most of your time'**
  String get premiumSheetTitle;

  /// No description provided for @fiveStarsLabel.
  ///
  /// In en, this message translates to:
  /// **'5 stars'**
  String get fiveStarsLabel;

  /// No description provided for @premiumFeatureListTitle.
  ///
  /// In en, this message translates to:
  /// **'What you get with Premium'**
  String get premiumFeatureListTitle;

  /// No description provided for @premiumFeatureAdRemovalLabel.
  ///
  /// In en, this message translates to:
  /// **'Hides all ads'**
  String get premiumFeatureAdRemovalLabel;

  /// No description provided for @premiumFeatureAdRemovalEmphasis.
  ///
  /// In en, this message translates to:
  /// **'all ads'**
  String get premiumFeatureAdRemovalEmphasis;

  /// No description provided for @premiumFeatureWidgetLabel.
  ///
  /// In en, this message translates to:
  /// **'Check at a glance with the widget'**
  String get premiumFeatureWidgetLabel;

  /// No description provided for @premiumFeatureWidgetEmphasis.
  ///
  /// In en, this message translates to:
  /// **'widget'**
  String get premiumFeatureWidgetEmphasis;

  /// No description provided for @oneTimePurchaseLabel.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase'**
  String get oneTimePurchaseLabel;

  /// No description provided for @oneTimePurchaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Pay once, yours forever.'**
  String get oneTimePurchaseDescription;

  /// No description provided for @purchaseButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchaseButtonLabel;

  /// No description provided for @storeUnavailableContent.
  ///
  /// In en, this message translates to:
  /// **'The store is currently unavailable.'**
  String get storeUnavailableContent;

  /// No description provided for @purchaseSuccessContent.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Premium features are now unlocked.'**
  String get purchaseSuccessContent;

  /// No description provided for @purchasePendingContent.
  ///
  /// In en, this message translates to:
  /// **'Your purchase is pending approval.'**
  String get purchasePendingContent;

  /// No description provided for @purchaseErrorContent.
  ///
  /// In en, this message translates to:
  /// **'The purchase could not be completed. Please try again.'**
  String get purchaseErrorContent;

  /// No description provided for @restorePurchasesLabel.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchasesLabel;

  /// No description provided for @restoreRequestedContent.
  ///
  /// In en, this message translates to:
  /// **'Restoring purchases...'**
  String get restoreRequestedContent;

  /// No description provided for @todaysMessageHint.
  ///
  /// In en, this message translates to:
  /// **'This moment is the youngest you\'ll ever be.'**
  String get todaysMessageHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
