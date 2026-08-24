import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/premium_widget_sync_provider.dart';
import 'package:life_battery/src/features/purchases/presentation/providers/purchase_updates_provider.dart';
import 'package:life_battery/src/features/settings/presentation/providers/app_theme_mode_provider.dart';
import 'package:life_battery/src/l10n/app_localizations.dart';
import 'package:life_battery/src/routing/app_router.dart';
import 'package:life_battery/src/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Activates the app-wide purchase stream listener at startup.
    // Purchases are sold on the App Store only.
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      ref
        ..watch(purchaseUpdatesProvider)
        ..watch(premiumWidgetSyncProvider);
    }

    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(appThemeModeProvider).value ?? ThemeMode.system;

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Life Battery',
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      themeMode: themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
        Locale('en'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        const defaultLocale = Locale('en');
        return supportedLocales.firstWhereOrNull(
              (supportedLocale) =>
                  supportedLocale.languageCode == locale?.languageCode,
            ) ??
            defaultLocale;
      },
    );
  }
}
