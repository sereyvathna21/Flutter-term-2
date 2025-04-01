import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/EXAMPLE%201/provider/pancake_provider.dart';
import 'package:week_3_blabla_project/EXAMPLE%201/repository/%20firebase_pancake_repository.dart';
import 'package:week_3_blabla_project/EXAMPLE%201/repository/pancake_repository.dart';
import 'package:week_3_blabla_project/EXAMPLE%201/ui/screens/pancake_screen.dart';

void main() async {
  final PancakeRepository pancakeRepository = FirebasePancakeRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => Pancakeprovider(pancakeRepository),
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: const PancakeScreen()),
    ),
  );
}
