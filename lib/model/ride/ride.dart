import 'package:week_3_blabla_project/model/ride/locations.dart';
import '../../utils/date_time_util.dart';
import '../user/user.dart';

enum RideStatus {
  created,
  published,
  ongoing,
  finished,
}

///
/// This model describes a Ride.
///
class Ride {
  final Location departureLocation;
  final DateTime departureDate;
  final Location arrivalLocation;
  final int requestedSeats;
  final bool petsAccepted;

  RideStatus status = RideStatus.created;

  final List<User> passengers = [];

  Ride({
    required this.departureLocation,
    required this.departureDate,
    required this.arrivalLocation,
    required this.requestedSeats,
    required this.petsAccepted,
    required String user,
  });

  // Calculate arrivalDateTime based on departureDate and duration
  DateTime get arrivalDateTime =>
      departureDate.add(Duration(hours: 2)); // Example duration

  void addPassenger(User passenger) {
    passengers.add(passenger);
  }

  int get remainingSeats => requestedSeats - passengers.length;

  @override
  String toString() {
    return 'Ride from $departureLocation at ${DateTimeUtils.formatDateTime(departureDate)} '
        'to $arrivalLocation arriving at ${DateTimeUtils.formatDateTime(arrivalDateTime)}, '
        'Seats: $requestedSeats, Pets Accepted: $petsAccepted';
  }
}
