import '../model/ride/ride.dart';

import '../model/ride_pref/ride_pref.dart';
import '../service/rides_service.dart';

abstract class RideRepository {
  /// Returns a list of rides based on the given preferences, filters, and sort type.
  /// If no rides match the criteria, an empty list is returned.
  List<Ride> getRides(
    RidePreference preference,
    RidesFilter? filter,
    RideSortType? sortType,
  );
}
