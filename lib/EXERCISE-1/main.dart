import 'model/RidePreferencesService.dart';
import 'screen/RidePreferencesListener.dart';

class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceChanged(String newPreference) {
    print('Preference changed to: $newPreference');
  }
}

void main() {
  var ridePreferencesService = RidePreferencesService('Comfort');
  var consoleLogger = ConsoleLogger();

  // Register observers
  ridePreferencesService.addListener(consoleLogger);

  // Update preferences
  print("🚗 Setting preference to Economy...");
  ridePreferencesService.setPreference('Economy');

  print("🚗 Setting preference to Luxury...");
  ridePreferencesService.setPreference('Luxury');
}
