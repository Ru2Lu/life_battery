/// Where the premium bottom sheet was opened from, reported as the source
/// parameter of the paywall_view analytics event.
enum PaywallSource {
  settings('settings');

  const PaywallSource(this.paramValue);

  final String paramValue;
}
