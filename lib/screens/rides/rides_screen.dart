import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_pref_bar.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/service/ride_prefs_service.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/repository/mock/mock_ride_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/rides_tile.dart';
import 'widgets/ride_pref_modal.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RidePreference? currentPreference;
  final RidesService ridesService = RidesService(MockRidesRepository());

  @override
  void initState() {
    super.initState();
    // Get the current preference from the service or use a default one
    currentPreference = RidePrefService.instance.currentPreference ??
        RidePreference(
          departure: fakeLocations[30], // Battambang
          arrival: fakeLocations[35], // Siem Reap
          departureDate: DateTime.now(), // Match the fakeRides
          requestedSeats: 1,
          petsAccepted: false,
        );
  }

  List<Ride> get matchingRides {
    final rides = ridesService.getRidesFor(currentPreference ??
        RidePreference(
          departure: fakeLocations[30], // Battambang
          arrival: fakeLocations[35], // Siem Reap
          departureDate: DateTime.now(), // Match the fakeRides
          requestedSeats: 1,
          petsAccepted: false,
        ));

    // Filter rides where requestedSeats > 0
    final availableRides =
        rides.where((ride) => ride.requestedSeats > 0).toList();

    print('Matching Rides: $availableRides'); // Debugging
    return availableRides;
  }

  void onBackPressed() {
    Navigator.of(context).pop(); // Back to the previous view
  }

  void onPreferencePressed() async {
    final updatedPreference = await showModalBottomSheet<RidePreference>(
      context: context,
      builder: (context) => RidePrefModal(
        initialPreference: currentPreference,
      ),
    );

    if (updatedPreference != null) {
      print('Updated Preference: $updatedPreference'); // Debugging
      setState(() {
        currentPreference = updatedPreference;
      });
      // Update the service current preference
      RidePrefService.instance.setCurrentPreference(updatedPreference);
      // Optionally, add the preference to past preferences
      RidePrefService.instance.addPreference(updatedPreference);
    }
  }

  void onFilterPressed() {
    // Handle filter button press
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            // Top search Search bar
            RidePrefBar(
                ridePreference: currentPreference ??
                    RidePreference(
                      departure: fakeLocations[30], // Battambang
                      arrival: fakeLocations[35], // Siem Reap
                      departureDate: DateTime.now(), // Match the fakeRides
                      requestedSeats: 1,
                      petsAccepted: false,
                    ),
                onBackPressed: onBackPressed,
                onPreferencePressed: onPreferencePressed,
                onFilterPressed: onFilterPressed),

            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideTile(
                  ride: matchingRides[index],
                  onPressed: () {
                    // Handle ride selection
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
