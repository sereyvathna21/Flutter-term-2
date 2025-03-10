import 'model/RidePreferencesService.dart';
import 'screen/ConsoleLogger.dart';

void main() {
  var ridePreferencesService = RidePreferencesService('Comfort');
  var consoleLogger = ConsoleLogger();

  ridePreferencesService.addListener(consoleLogger);

  ridePreferencesService.setPreference('Economy');
  ridePreferencesService.setPreference('Luxury');
}
