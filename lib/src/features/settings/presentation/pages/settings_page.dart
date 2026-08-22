import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:life_battery/src/features/purchases/presentation/widgets/remove_ads_list_tile.dart';
import 'package:life_battery/src/features/settings/presentation/widgets/appearance_list_tile.dart';
import 'package:life_battery/src/features/settings/presentation/widgets/delete_all_list_tile.dart';
import 'package:life_battery/src/features/settings/presentation/widgets/notification_settings_list_tile.dart';
import 'package:life_battery/src/features/settings/presentation/widgets/privacy_policy_list_tile.dart';
import 'package:life_battery/src/features/settings/presentation/widgets/review_app_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          const RemoveAdsListTile(),
          const ReviewAppListTile(),
          const PrivacyPolicyListTile(
            canLaunchUrl: canLaunchUrl,
            onLaunchUrl: launchUrl,
          ),
          const AppearanceListTile(),
          NotificationSettingsListTile(
            onOpenSettings: () => AppSettings.openAppSettings(
              type: AppSettingsType.notification,
            ),
          ),
          const DeleteAllListTile(),
        ],
      ),
    );
  }
}
