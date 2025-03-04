import '../model/ride_pref/ride_pref.dart';

abstract class RidePreferencesRepository {
  List<RidePref> getPastPreferences();

  void addPreference(RidePref preference);
}
