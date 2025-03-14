import '../models/course.dart';
import 'mock_repository.dart';

List<Course> getCourses() => getCoursesFromMock();

void addScore(Course course, CourseScore score) =>
    addScoreToMock(course, score);
