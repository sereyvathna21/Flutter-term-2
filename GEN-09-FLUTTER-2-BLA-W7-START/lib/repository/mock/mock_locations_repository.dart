import '../../model/location/locations.dart';
import '../locations_repository.dart';

class MockLocationsRepository extends LocationsRepository {
  static const Location phnomPenh = Location(
    name: "Phnom Penh",
    country: Country.cambodia,
  );
  static const Location siemReap = Location(
    name: "Siem Reap",
    country: Country.cambodia,
  );
  static const Location sihanoukville = Location(
    name: "Sihanoukville",
    country: Country.cambodia,
  );
  static const Location kampot =
      Location(name: "Kampot", country: Country.cambodia);
  static const Location battambang = Location(
    name: "Battambang",
    country: Country.cambodia,
  );

  @override
  List<Location> getLocations() {
    return [phnomPenh, siemReap, sihanoukville, kampot, battambang];
  }
}
