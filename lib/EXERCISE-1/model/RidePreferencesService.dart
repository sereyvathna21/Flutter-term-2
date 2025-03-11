// ignore: file_names
import '../screen/RidePreferencesListener.dart';

class RidePreferencesService {
  String _currentPreference;
  final List<RidePreferencesListener> _listeners = [];

  RidePreferencesService(this._currentPreference);

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void notifyListeners() {
    for (var listener in _listeners) {
      listener.onPreferenceChanged(_currentPreference);
    }
  }

  void setPreference(String newPreference) {
    _currentPreference = newPreference;
    notifyListeners();
  }

  String get currentPreference => _currentPreference;
}
