import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/settings/presentation/pages/settings_page.dart';
import 'package:life_battery/src/features/settings/presentation/providers/app_theme_mode_provider.dart';
import 'package:life_battery/src/features/settings/presentation/widgets/notification_settings_list_tile.dart';
import 'package:life_battery/src/features/settings/presentation/widgets/privacy_policy_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../test_helpers/test_app.dart';

void main() {
  group('Privacy policy', () {
    testWidgets('Displays privacy policy label', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(const TestSettingsPage());

      expect(find.text('Privacy policy'), findsOneWidget);
    });

    testWidgets('Opens in-app browser URL when tapped', (
      tester,
    ) async {
      Uri? launchedUrl;
      LaunchMode? launchMode;

      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(
        ProviderScope(
          child: TestApp(
            home: Scaffold(
              body: PrivacyPolicyListTile(
                canLaunchUrl: (_) async => true,
                onLaunchUrl: (url, {mode = LaunchMode.platformDefault}) async {
                  launchedUrl = url;
                  launchMode = mode;
                  return true;
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PrivacyPolicyListTile));
      await tester.pumpAndSettle();

      expect(
        launchedUrl.toString(),
        'https://renusuda.github.io/life_battery_privacy_policy/en',
      );
      expect(launchMode, LaunchMode.inAppBrowserView);
    });
  });

  group('Notification settings', () {
    testWidgets('Displays notification settings label', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(const TestSettingsPage());

      expect(find.text('Notification settings'), findsOneWidget);
    });

    testWidgets('Invokes onOpenSettings callback when tapped', (tester) async {
      var called = false;

      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(
        ProviderScope(
          child: TestApp(
            home: Scaffold(
              body: NotificationSettingsListTile(
                onOpenSettings: () => called = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(NotificationSettingsListTile));
      await tester.pumpAndSettle();

      expect(called, isTrue);
    });
  });

  group('Delete data', () {
    testWidgets('Displays delete all label', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(const TestSettingsPage());

      expect(find.text('Delete Data'), findsOneWidget);
    });

    testWidgets('Shows confirmation dialog when tapped', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(const TestSettingsPage());

      await tester.tap(find.text('Delete Data'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('Dismisses dialog when cancel is tapped', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(const TestSettingsPage());

      await tester.tap(find.text('Delete Data'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
    });
  });

  group('Appearance', () {
    testWidgets('Shows light mode when light mode is selected', (
      tester,
    ) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appThemeModeProvider.overrideWith(FakeAppThemeMode.new),
          ],
          child: const TestSettingsApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Appearance'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Light').hitTestable());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(SettingsPage));
      expect(Theme.of(context).brightness, Brightness.light);
    });

    testWidgets('Shows dark mode when dark mode is selected', (
      tester,
    ) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appThemeModeProvider.overrideWith(FakeAppThemeMode.new),
          ],
          child: const TestSettingsApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Appearance'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Dark').hitTestable());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(SettingsPage));
      expect(Theme.of(context).brightness, Brightness.dark);
    });
  });

  group('Remove ads', () {
    testWidgets('Displays remove ads label', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(const TestSettingsPage());
      await tester.pumpAndSettle();

      expect(find.text('Remove ads'), findsOneWidget);
    });

    testWidgets('Displays Japanese remove ads label', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('ja')];
      await tester.pumpWidget(const TestSettingsPage());
      await tester.pumpAndSettle();

      expect(find.text('広告を削除'), findsOneWidget);
    });
  });

  group('Localization tests', () {
    testWidgets('Device locale is English when set to English', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('en')];
      await tester.pumpWidget(
        const TestSettingsPage(),
      );
      expect(find.text('Rate this app'), findsOneWidget);
    });
    testWidgets('Device locale is Chinese when set to English', (tester) async {
      tester.platformDispatcher.localesTestValue = [const Locale('zh')];
      await tester.pumpWidget(
        const TestSettingsPage(),
      );
      expect(find.text('Rate this app'), findsOneWidget);
    });
    testWidgets('Device locale is Japanese when set to Japanese', (
      tester,
    ) async {
      tester.platformDispatcher.localesTestValue = [const Locale('ja')];
      await tester.pumpWidget(
        const TestSettingsPage(),
      );
      expect(find.text('アプリをレビューする'), findsOneWidget);
    });
  });
}

class TestSettingsPage extends StatelessWidget {
  const TestSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: TestApp(
        home: SettingsPage(),
      ),
    );
  }
}

class TestSettingsApp extends ConsumerWidget {
  const TestSettingsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeMode = ref.watch(appThemeModeProvider);

    return switch (appThemeMode) {
      AsyncData(:final value) => TestApp(
        themeMode: value,
        home: const SettingsPage(),
      ),
      AsyncError() => const TestApp(
        home: SizedBox.shrink(),
      ),
      _ => const TestApp(
        home: Scaffold(
          body: CircularProgressIndicator(),
        ),
      ),
    };
  }
}

class FakeAppThemeMode extends AppThemeMode {
  @override
  Future<ThemeMode> build() async => ThemeMode.system;

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    state = AsyncData(themeMode);
  }
}
