import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../model/user/user.dart';
import '../ride_pref_screen.dart';
import 'blabutton.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref initRidePref;

  const RidePrefForm({required this.initRidePref, super.key});

  @override
  _RidePrefFormState createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _departureController;
  late TextEditingController _arrivalController;
  late TextEditingController _dateController;
  late TextEditingController _seatsController;

  @override
  void initState() {
    super.initState();
    _departureController =
        TextEditingController(text: widget.initRidePref.departure.name);
    _arrivalController =
        TextEditingController(text: widget.initRidePref.arrival.name);
    _dateController = TextEditingController(
      text: widget.initRidePref.departureDate.toString().isEmpty
          ? 'Today'
          : widget.initRidePref.departureDate.toString(),
    );
    _seatsController = TextEditingController(
        text: widget.initRidePref.requestedSeats.toString());

    _departureController.addListener(_updateSwapButtonVisibility);
    _arrivalController.addListener(_updateSwapButtonVisibility);
  }

  @override
  void dispose() {
    _departureController.removeListener(_updateSwapButtonVisibility);
    _arrivalController.removeListener(_updateSwapButtonVisibility);
    _departureController.dispose();
    _arrivalController.dispose();
    _dateController.dispose();
    _seatsController.dispose();
    super.dispose();
  }

  bool _showSwapButton = false;

  void _updateSwapButtonVisibility() {
    setState(() {
      _showSwapButton = _departureController.text.isNotEmpty &&
          _arrivalController.text.isNotEmpty;
    });
  }

  void _onSearch() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FakeRidesScreen(
            ride: Ride(
              departureLocation: Location(
                  name: _departureController.text, country: Country.france),
              departureDate: DateTime.parse(_dateController.text),
              arrivalLocation: Location(
                  name: _arrivalController.text, country: Country.france),
              arrivalDateTime: DateTime.parse(_dateController.text),
              driver: User(
                firstName: 'Driver',
                lastName: 'Name',
                email: 'driver@example.com',
                phone: '1234567890',
                profilePicture: 'path/to/profile/picture',
                verifiedProfile: true,
              ), // Replace with actual driver data
              availableSeats: int.parse(_seatsController.text),
              pricePerSeat: 10.0, // Replace with actual price data
            ),
          ),
        ),
      );
    }
  }

  void _swapLocations() {
    setState(() {
      final temp = _departureController.text;
      _departureController.text = _arrivalController.text;
      _arrivalController.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _departureController,
                  decoration: const InputDecoration(
                    labelText: 'Leaving from',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a departure location';
                    }
                    return null;
                  },
                ),
              ),
              if (_showSwapButton)
                IconButton(
                  icon: const Icon(Icons.swap_vert),
                  onPressed: _swapLocations,
                ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _arrivalController,
            decoration: const InputDecoration(
              labelText: 'Going to',
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an arrival location';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: 'Today',
              prefixIcon: Icon(Icons.calendar_today),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a date';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _seatsController,
            decoration: const InputDecoration(
              labelText: 'Passengers',
              prefixIcon: Icon(Icons.person),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of passengers';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: BlaButton(
              type: BlaButtonType.primary,
              onPressed: _onSearch,
              text: 'Search',
            ),
          ),
        ],
      ),
    );
  }
}
