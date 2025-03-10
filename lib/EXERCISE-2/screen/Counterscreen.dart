import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ColorCounters.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<ColorCounters>(
        builder: (context, colorCounters, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: colorCounters.incrementCounter1,
                child: Container(
                  width: 300,
                  height: 100,
                  color: Colors.red,
                  child: Center(child: Text('Tap: ${colorCounters.counter1}')),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: colorCounters.incrementCounter2,
                child: Container(
                  width: 300,
                  height: 100,
                  color: Colors.blue,
                  child: Center(child: Text('Tap: ${colorCounters.counter2}')),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
