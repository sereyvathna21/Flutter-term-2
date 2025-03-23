import 'package:flutter/material.dart';
import '../../model/ride/ride_pref.dart';
import '../../repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  final List<RidePreference> _pastPreferences = [];

  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    // For now past preferences are fetched only 1 time
    _pastPreferences.addAll(repository.getPastPreferences());
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreferrence(RidePreference pref) {
    if (pref != _currentPreference) {
      _currentPreference = pref;

      if (!_pastPreferences.contains(pref)) {
        _addPreference(pref);
      } else {
        // Move the existing preference to the end of the list
        _pastPreferences.remove(pref);
        _addPreference(pref);
      }
      notifyListeners();
    }
  }

  void _addPreference(RidePreference preference) {
    _pastPreferences.add(preference);
  }

  List<RidePreference> get preferencesHistory =>
      _pastPreferences.reversed.toList();
}
