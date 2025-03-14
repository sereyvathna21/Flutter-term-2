import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/course_provider.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseProvider()..fetchCourses(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CourseListScreen(),
      ),
    );
  }
}
