import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ColorCounters.dart';

class StaticScreen extends StatelessWidget {
  const StaticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ColorCounters>(
        builder: (context, colorCounters, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Red Tap: ${colorCounters.counter1}'),
              SizedBox(height: 20),
              Text('Blue Tap: ${colorCounters.counter2}'),
            ],
          );
        },
      ),
    );
  }
}
