import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart'; // Import the Ride model
import 'package:week_3_blabla_project/model/user/user.dart'; // Import the User model
import '../../model/ride_pref/ride_pref.dart';
import '../../theme/theme.dart';
import '../../utils/date_time_util.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';
import 'package:week_3_blabla_project/service/rides_service.dart'; // Import the RideService

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class RidePrefScreen extends StatefulWidget {
  const RidePrefScreen({super.key});

  @override
  State<RidePrefScreen> createState() => _RidePrefScreenState();
}

class _RidePrefScreenState extends State<RidePrefScreen> {
  void onRideSelected(Ride ride) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FakeRidesScreen(ride: ride)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BlaBackground(),
        Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "Your pick of rides at low price",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 100),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RidePrefForm(
                    initRidePref: RidePref(
                      departure: Location(name: '', country: Country.france),
                      departureDate: DateTime.now(),
                      arrival: Location(name: '', country: Country.france),
                      requestedSeats: 1,
                    ),
                  ),
                  const SizedBox(height: BlaSpacings.m),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: RidesService.availableRides.length,
                      itemBuilder: (ctx, index) => RidePrefHistoryTile(
                        ridePref: RidePref(
                          departure:
                              Location(name: '', country: Country.france),
                          departureDate: DateTime.now(),
                          arrival: Location(name: '', country: Country.france),
                          requestedSeats: 1,
                        ),
                        onPressed: () => onRideSelected(
                          RidesService.availableRides[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FakeRidesScreen extends StatelessWidget {
  final Ride ride;

  const FakeRidesScreen({required this.ride, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your pick of rides at low price'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RideCard(ride: ride),
        ],
      ),
    );
  }
}

class RideCard extends StatelessWidget {
  final Ride ride;

  const RideCard({required this.ride, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${ride.departureLocation.name} - ${ride.arrivalLocation.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Date: ${DateTimeUtils.formatDateTime(ride.departureDate)}'),
            const SizedBox(height: 8),
            Text('Passengers: ${ride.remainingSeats} seats available'),
            const SizedBox(height: 8),
            Text('Price: \$${ride.pricePerSeat.toStringAsFixed(2)} per seat'),
          ],
        ),
      ),
    );
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
