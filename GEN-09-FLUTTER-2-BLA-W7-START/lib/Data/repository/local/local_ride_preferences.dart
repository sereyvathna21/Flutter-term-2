import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../../../model/ride/ride_pref.dart';
import '../ride_preferences_repository.dart';

abstract class LocalRidePreferencesRepository
    extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<void> addPreference(RidePreference preference) async {
    // Get past preferences
    final preferences = await getPastPreferences();
    // Add the new preference
    preferences.add(preference);
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Save the new list as a string list
    await prefs.setStringList(
      _preferencesKey,
      preferences.map((pref) => jsonEncode(pref.toJson())).toList(),
    );
  }

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Get the string list from the key
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];
    // Convert the string list to a list of RidePreferenceDtos – Using map()
    return prefsList
        .map((json) => RidePreference.fromJson(jsonDecode(json)))
        .toList();
  }
}
