import 'package:flutter/foundation.dart';

class ColorCounters extends ChangeNotifier {
  int _counter1;
  int _counter2;

  ColorCounters({int counter1 = 0, int counter2 = 0})
      : _counter1 = counter1,
        _counter2 = counter2;

  int get counter1 => _counter1;
  int get counter2 => _counter2;

  void incrementCounter1() {
    _counter1++;
    notifyListeners();
  }

  void incrementCounter2() {
    _counter2++;
    notifyListeners();
  }
}
