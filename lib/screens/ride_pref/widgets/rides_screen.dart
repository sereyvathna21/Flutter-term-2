import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import 'ride_card.dart';

class RidesScreen extends StatelessWidget {
  final List<Ride> matchingRides;

  const RidesScreen({required this.matchingRides, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Matching Rides'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: matchingRides.length,
        itemBuilder: (context, index) {
          return RideCard(ride: matchingRides[index]);
        },
      ),
    );
  }
}
