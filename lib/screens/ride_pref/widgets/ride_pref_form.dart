import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../service/rides_service.dart'; // Import the RidesService
import 'blabutton.dart';
import 'location_picker_screen.dart';
import 'rides_screen.dart'; // Import the RidesScreen
import '../../../utils/animations_util.dart'; // Import the AnimationUtils

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

  final List<Location> _locations = [
    Location(name: 'Paris', country: Country.france),
    Location(name: 'London', country: Country.uk),
    Location(name: 'Madrid', country: Country.spain),
  ];

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
      // Replace with actual logic to fetch matching rides
      final matchingRides = RidesService.availableRides.where((ride) {
        return ride.departureLocation.name == _departureController.text &&
            ride.arrivalLocation.name == _arrivalController.text &&
            ride.departureDate.toString() == _dateController.text;
      }).toList();

      Navigator.push(
        context,
        AnimationUtils.createBottomToTopRoute(
          RidesScreen(matchingRides: matchingRides),
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

  void _pickLocation(TextEditingController controller) async {
    final Location? selectedLocation = await Navigator.push<Location>(
      context,
      AnimationUtils.createBottomToTopRoute(
        LocationPickerScreen(locations: _locations),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        controller.text = selectedLocation.name;
      });
    }
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
                child: GestureDetector(
                  onTap: () => _pickLocation(_departureController),
                  child: AbsorbPointer(
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
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickLocation(_arrivalController),
                  child: AbsorbPointer(
                    child: TextFormField(
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
                  ),
                ),
              ),
            ],
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
