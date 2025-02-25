import 'package:flutter/material.dart';
import 'blabutton.dart'; // Import the BlaButton
import 'blaicon.dart'; // Import the BlaIcon

class AdjustPassengerScreen extends StatefulWidget {
  final int initialPassengers;

  const AdjustPassengerScreen({required this.initialPassengers, super.key});

  @override
  _AdjustPassengerScreenState createState() => _AdjustPassengerScreenState();
}

class _AdjustPassengerScreenState extends State<AdjustPassengerScreen> {
  late int _passengers;

  @override
  void initState() {
    super.initState();
    _passengers = widget.initialPassengers;
  }

  void _incrementPassengers() {
    setState(() {
      _passengers++;
    });
  }

  void _decrementPassengers() {
    if (_passengers > 1) {
      setState(() {
        _passengers--;
      });
    }
  }

  void _savePassengers() {
    Navigator.of(context).pop(_passengers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('How many Passengers'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: BlaIcon(
                    icon: Icons.remove_circle_outline,
                    size: 36,
                    color: _passengers > 1 ? null : Colors.grey,
                  ),
                  onPressed: _decrementPassengers,
                ),
                Center(
                  child: Text(
                    '$_passengers',
                    style: const TextStyle(fontSize: 70),
                  ),
                ),
                IconButton(
                  icon: const BlaIcon(
                    icon: Icons.add_circle_outline,
                    size: 36,
                  ),
                  onPressed: _incrementPassengers,
                ),
              ],
            ),
          ),
          Container(
            width: 150,
            margin: const EdgeInsets.only(bottom: 70),
            child: BlaButton(
              type: BlaButtonType.primary,
              text: 'Confirm',
              onPressed: _savePassengers,
            ),
          ),
        ],
      ),
    );
  }
}
