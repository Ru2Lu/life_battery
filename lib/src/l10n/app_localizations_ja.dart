// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get generalError => 'エラーが発生しました。';

  @override
  String get birthDateLabel => '生年月日';

  @override
  String get idealLifespanLabel => '理想の寿命';

  @override
  String get ageUnit => '歳';

  @override
  String get dayUnit => '日';

  @override
  String get reviewAppLabel => 'アプリをレビューする';

  @override
  String get privacyPolicyLabel => 'プライバシーポリシー';

  @override
  String get appearanceLabel => '表示モード';

  @override
  String get systemLabel => 'システム';

  @override
  String get lightLabel => 'ライト';

  @override
  String get darkLabel => 'ダーク';

  @override
  String get deleteAllLabel => 'データを削除';

  @override
  String get deleteTitle => '全てのデータを削除';

  @override
  String get deleteContent => '本当にデータを削除しますか？\n一度削除されたデータは元に戻すことができません。';

  @override
  String get cancelLabel => 'キャンセル';

  @override
  String get deleteLabel => '削除';

  @override
  String get userDeletionSuccess =>
      'データを削除できました。\nアプリを使用してくださりありがとうございます。\nまたいつかお会いしましょう😊';

  @override
  String get notificationSettingsLabel => '通知設定';

  @override
  String notificationTitle(int percentage) {
    return '人生が残り$percentage%になりました';
  }

  @override
  String get notificationBody => '次の1%を、最高の物語にしましょう！';

  @override
  String get notificationBodyZeroPercent =>
      'あなたの物語は、誰かの物語の中で生き続けます。ありがとうございました。';

  @override
  String get longPressToEditHint => '長押しで人生を編集';

  @override
  String get premiumLabel => 'プレミアム';

  @override
  String get premiumDescriptionContent => 'すべての機能を解放';

  @override
  String get premiumPurchasedLabel => '購入済み';

  @override
  String get premiumSheetTitle => '残りの時間をもっと大切に';

  @override
  String get fiveStarsLabel => '5 stars';

  @override
  String get premiumFeatureListTitle => 'プレミアムでできること';

  @override
  String get premiumFeatureAdRemovalLabel => 'すべての広告を非表示';

  @override
  String get premiumFeatureAdRemovalEmphasis => 'すべての広告';

  @override
  String get premiumFeatureWidgetLabel => 'ウィジェットでひと目でチェック';

  @override
  String get premiumFeatureWidgetEmphasis => 'ウィジェット';

  @override
  String get oneTimePurchaseLabel => '買い切り';

  @override
  String get monthlyPlanLabel => '月額';

  @override
  String monthlyPriceLabel(String price) {
    return '$price/月';
  }

  @override
  String get monthlySubscriptionDescription => '毎月自動更新。いつでも解約できます。';

  @override
  String get oneTimePurchaseDescription => 'お支払いは一度だけ。すべての機能をずっとご利用いただけます。';

  @override
  String get purchaseButtonLabel => '購入';

  @override
  String get storeUnavailableContent => '現在ストアを利用できません。';

  @override
  String get purchaseSuccessContent => 'ご購入ありがとうございます。プレミアム機能を利用できるようになりました。';

  @override
  String get purchasePendingContent => '購入は承認待ちです。';

  @override
  String get purchaseErrorContent => '購入を完了できませんでした。もう一度お試しください。';

  @override
  String get restorePurchasesLabel => '以前の購入を復元';

  @override
  String get todaysMessageHint => 'この瞬間が、一番若い自分';
}
