import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/ride/ride_pref.dart';
import '../../Dto/ride_pref_dto.dart';
import '../ride_preferences_repository.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = 'ride_preferences';

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];
    return prefsList
        .map((json) => RidePreferenceDto.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    final existingPreferences = await getPastPreferences();
    existingPreferences.removeWhere((pref) => pref == preference);
    existingPreferences.add(preference);
    await prefs.setStringList(
      _preferencesKey,
      existingPreferences
          .map((pref) => jsonEncode(RidePreferenceDto.toJson(pref)))
          .toList(),
    );
  }
}
