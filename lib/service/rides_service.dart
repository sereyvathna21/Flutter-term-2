import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

///
/// This service handles:
/// - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  ///
  /// Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePref preferences) {
    return availableRides.where((ride) {
      return ride.departureLocation.name == preferences.departure.name &&
          ride.arrivalLocation.name == preferences.arrival.name &&
          ride.departureDate.isAtSameMomentAs(preferences.departureDate);
    }).toList();
  }
}
