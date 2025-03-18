import '../models/course.dart';

abstract class CourseRepository {
  List<Course> getCourses();

  void addScore(Course course, CourseScore score);
}

class MockCourseRepository extends CourseRepository {
  final List<Course> _courses = [];

  List<Course> getCoursesFromMock() => _courses;

  @override
  List<Course> getCourses() => getCoursesFromMock();

  void addScoreToMock(Course course, CourseScore score) {
    // Implementation for adding score
  }

  @override
  void addScore(Course course, CourseScore score) =>
      addScoreToMock(course, score);
}
