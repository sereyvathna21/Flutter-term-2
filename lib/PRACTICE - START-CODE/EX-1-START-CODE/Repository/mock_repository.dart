import '../models/course.dart';

List<Course> _courses = [
  Course(id: 1, name: 'HTML', scores: []),
  Course(id: 2, name: 'JAVA', scores: []),
];

List<Course> getCoursesFromMock() {
  return _courses;
}

void addScoreToMock(Course course, CourseScore score) {
  course.addScore(score);
}
