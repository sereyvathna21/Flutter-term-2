import 'package:week_3_blabla_project/model/ride/ride.dart';

import 'package:week_3_blabla_project/service/rides_service.dart';

import '../../dummy_data/dummy_data.dart' show fakeLocations;
import '../../model/ride_pref/ride_pref.dart';
import '../ride_repository.dart';

class MockRidesRepository implements RideRepository {
  final List<RidePreference> pastPreferences = [
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
      requestedSeats: 2,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 8)),
      requestedSeats: 1, // Fixed: Changed from 0 to 1
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5)),
      requestedSeats: 1,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 8)),
      requestedSeats: 2,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5)),
      requestedSeats: 1,
    ),
  ];

  @override
  List<Ride> getRides(
      RidePreference preference, RidesFilter? filter, RideSortType? sortType) {
    throw UnimplementedError();
  }
}
