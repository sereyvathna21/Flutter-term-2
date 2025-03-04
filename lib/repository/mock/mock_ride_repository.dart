import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart'
    show fakeLocations, fakeRides;
import '../../service/rides_service.dart';
import '../ride_repository.dart';

class MockRidesRepository implements RideRepository {
  final List<RidePreference> pastPreferences = [
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
      requestedSeats: 2,
      petsAccepted: false,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 8)),
      requestedSeats: 1,
      petsAccepted: false,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5)),
      requestedSeats: 1,
      petsAccepted: false,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 8)),
      requestedSeats: 2,
      petsAccepted: true,
    ),
    RidePreference(
      departure: fakeLocations[40], // Battambang
      arrival: fakeLocations[39], // Siem Reap
      departureDate: DateTime.now().add(Duration(hours: 5)),
      requestedSeats: 1,
      petsAccepted: false,
    ),
  ];

  @override
  List<Ride> getRides(
    RidePreference preference,
    RidesFilter? filter,
    RideSortType? sortType,
  ) {
    // Filter rides based on the preference (departure, arrival, and date)
    final filteredRides = fakeRides.where((ride) =>
        ride.departureLocation == preference.departure &&
        ride.arrivalLocation == preference.arrival &&
        ride.departureDate.isAtSameMomentAs(preference.departureDate));

    // Apply additional filters (e.g., petsAccepted)
    if (filter != null && filter.petsAccepted) {
      return filteredRides.where((ride) => ride.petsAccepted).toList();
    }

    // Return the filtered rides
    return filteredRides.toList();
  }
}
