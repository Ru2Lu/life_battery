import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:life_battery/src/features/data_deletion/data/data_deletion_repository_provider.dart';
import 'package:life_battery/src/features/data_deletion/presentation/pages/user_deleted_page.dart';
import 'package:life_battery/src/features/lifespan/presentation/pages/lifespan_progress_page.dart';
import 'package:life_battery/src/features/settings/presentation/pages/settings_page.dart';
import 'package:life_battery/src/routing/app_route.dart';
import 'package:life_battery/src/routing/go_router_refresh_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final dataDeletionRepository = ref.watch(dataDeletionRepositoryProvider);
  return GoRouter(
    observers: [
      // Integration tests build the app without Firebase.initializeApp, so
      // only attach the observer when a Firebase app exists.
      if (Firebase.apps.isNotEmpty)
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
    redirect: (context, state) {
      final isDeleted = dataDeletionRepository.isUserDeleted;
      if (isDeleted) {
        return '/user-deleted';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      dataDeletionRepository.isUserDeletedStateChanges(),
    ),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const LifespanProgressPage(),
        routes: [
          GoRoute(
            path: 'settings',
            name: AppRoute.settings.name,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/user-deleted',
        name: AppRoute.userDeleted.name,
        builder: (context, state) => const UserDeletedPage(),
      ),
    ],
  );
}
