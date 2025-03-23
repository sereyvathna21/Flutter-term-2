import 'package:flutter/material.dart';
import '../../model/ride/ride_pref.dart';
import '../../Data/repository/ride_preferences_repository.dart';
import 'async.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;

  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  Future<void> fetchPastPreferences() async {
    // 1- Handle loading
    pastPreferences = AsyncValue.loading();
    notifyListeners();
    try {
      // 2 Fetch data
      List<RidePreference> pastPrefs = await repository.getPastPreferences();
      // 3 Handle success
      pastPreferences = AsyncValue.success(pastPrefs);
    } catch (error) {
      // 4 Handle error
      pastPreferences = AsyncValue.error(error);
    }
    notifyListeners();
  }

  void setCurrentPreferrence(RidePreference pref) {
    if (pref != _currentPreference) {
      _currentPreference = pref;

      if (pastPreferences.data != null &&
          !pastPreferences.data!.contains(pref)) {
        _addPreference(pref);
      } else {
        // Move the existing preference to the end of the list
        pastPreferences.data!.remove(pref);
        _addPreference(pref);
      }
      notifyListeners();
    }
  }

  void _addPreference(RidePreference preference) async {
    await repository.addPreference(preference);
    await fetchPastPreferences();
  }

  List<RidePreference> get preferencesHistory =>
      pastPreferences.data?.reversed.toList() ?? [];
}
