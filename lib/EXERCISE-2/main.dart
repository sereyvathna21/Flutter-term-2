import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/ColorCounters.dart';
import 'screen/HomeScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorCounters(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('MyApp rebuild');
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
