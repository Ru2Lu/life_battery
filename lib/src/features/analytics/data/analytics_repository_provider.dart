import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:life_battery/src/features/analytics/data/analytics_repository.dart';
import 'package:life_battery/src/features/analytics/data/api/analytics_api_data_source.dart';
import 'package:life_battery/src/features/analytics/data/api/firebase_analytics_api_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AnalyticsApiDataSource analyticsApiDataSource(Ref ref) {
  return FirebaseAnalyticsApiDataSource(analytics: FirebaseAnalytics.instance);
}

@Riverpod(keepAlive: true)
AnalyticsRepository analyticsRepository(Ref ref) {
  final apiDataSource = ref.watch(analyticsApiDataSourceProvider);
  return AnalyticsRepository(apiDataSource: apiDataSource);
}
