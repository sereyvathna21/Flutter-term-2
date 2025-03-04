import '../model/ride_pref/ride_pref.dart';
import '../repository/ride_preferences_repository.dart';

class RidePrefService {
  static RidePrefService? _instance;
  final RidePreferencesRepository repository;
  RidePreference? _currentPreference;

  RidePrefService._internal(this.repository);

  static void initialize(RidePreferencesRepository repository) {
    _instance ??= RidePrefService._internal(repository);
  }

  static RidePrefService get instance {
    if (_instance == null) {
      throw Exception("RidePrefService is not initialized.");
    }
    return _instance!;
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference preference) {
    _currentPreference = preference;
  }

  List<RidePreference> getPastPreferences() {
    return repository.getPastPreferences();
  }

  void addPreference(RidePreference preference) {
    repository.addPreference(preference);
  }
}
