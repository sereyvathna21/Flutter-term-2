import 'package:flutter/material.dart';
import '../models/course.dart';
import '../Repository/course_repository.dart';

class CourseProvider with ChangeNotifier {
  final CourseRepository _repository;

  CourseProvider(this._repository);

  List<Course> _courses = [];

  List<Course> get courses => _courses;

  void fetchCourses() {
    _courses = _repository.getCourses();
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
    _repository.addScore(course, score);
    notifyListeners();
  }
}
