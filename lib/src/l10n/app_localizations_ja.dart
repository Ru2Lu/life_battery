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
  String get removeAdsLabel => '広告を削除';

  @override
  String get todaysMessageHint => 'この瞬間が、一番若い自分';
}
