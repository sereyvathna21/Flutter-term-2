// ignore: file_names
import 'RidePreferencesListener.dart';

class ConsoleLogger implements RidePreferencesListener {
  @override
  void onPreferenceChanged(String newPreference) {
    print('Preference changed to: $newPreference');
  }
}
