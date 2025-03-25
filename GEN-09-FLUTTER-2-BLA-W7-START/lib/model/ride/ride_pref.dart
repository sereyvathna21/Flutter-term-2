import '../location/locations.dart';

///
/// This model describes a ride preference.
/// A ride preference consists of the selection of a departure + arrival + a date and a number of passenger
///
class RidePreference {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  const RidePreference(
      {required this.departure,
      required this.departureDate,
      required this.arrival,
      required this.requestedSeats});

  @override
  String toString() {
    return 'RidePref(departure: ${departure.name}, '
        'departureDate: ${departureDate.toIso8601String()}, '
        'arrival: ${arrival.name}, '
        'requestedSeats: $requestedSeats)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RidePreference &&
        other.departure == departure &&
        other.departureDate == departureDate &&
        other.arrival == arrival &&
        other.requestedSeats == requestedSeats;
  }

  @override
  int get hashCode {
    return departure.hashCode ^
        departureDate.hashCode ^
        arrival.hashCode ^
        requestedSeats.hashCode;
  }

  // Convert a RidePreference object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'departure': departure.name,
      'departureDate': departureDate.toIso8601String(),
      'arrival': arrival.name,
      'requestedSeats': requestedSeats,
      'departureCountry': departure.country.name,
      'arrivalCountry': arrival.country.name,
    };
  }

  // Create a RidePreference object from a JSON map
  factory RidePreference.fromJson(Map<String, dynamic> json) {
    return RidePreference(
      departure: Location(
        name: json['departure'],
        country: Country.values
            .firstWhere((e) => e.name == json['departureCountry']),
      ),
      departureDate: DateTime.parse(json['departureDate']),
      arrival: Location(
        name: json['arrival'],
        country:
            Country.values.firstWhere((e) => e.name == json['arrivalCountry']),
      ),
      requestedSeats: json['requestedSeats'],
    );
  }
}
