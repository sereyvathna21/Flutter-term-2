import '../../model/ride/locations.dart';
import '../location_repository.dart';

class InMemoryLocationRepository implements LocationRepository {
  // Predefined list of Cambodian cities
  final List<Location> _locations = const [
    Location(name: "Phnom Penh", country: Country.cambodia),
    Location(name: "Siem Reap", country: Country.cambodia),
    Location(name: "Battambang", country: Country.cambodia),
    Location(name: "Sihanoukville", country: Country.cambodia),
    Location(name: "Kampot", country: Country.cambodia),
  ];

  @override
  List<Location> getAllLocations() {
    return List.unmodifiable(_locations);
  }

  @override
  Location? findLocationByName(String name) {
    return _locations.firstWhere(
      (location) => location.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
