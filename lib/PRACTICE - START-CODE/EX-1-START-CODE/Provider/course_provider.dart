import 'package:flutter/material.dart';
import '../models/course.dart';
import '../Repository/course_repository.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];

  List<Course> get courses => _courses;

  void fetchCourses() {
    _courses = getCourses();
    notifyListeners();
  }

  List<CourseScore> getScores(String courseId) {
    return _courses
        .firstWhere((course) => course.id.toString() == courseId)
        .scores;
  }

  void addScore(String courseId, CourseScore score) {
    Course course =
        _courses.firstWhere((course) => course.id.toString() == courseId);
    course.scores.add(score);
    notifyListeners();
  }
}
