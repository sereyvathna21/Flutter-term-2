import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import '../../../utils/date_time_util.dart';

class RideCard extends StatelessWidget {
  final Ride ride;

  const RideCard({required this.ride, Key? key}) : super(key: key);

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
            Text('Passengers: ${ride.availableSeats} seats available'),
            const SizedBox(height: 8),
            Text('Price: \$${ride.pricePerSeat.toStringAsFixed(2)} per seat'),
          ],
        ),
      ),
    );
  }
}
