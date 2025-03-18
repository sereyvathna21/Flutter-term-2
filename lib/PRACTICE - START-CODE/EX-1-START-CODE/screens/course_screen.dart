import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../Provider/course_provider.dart';
import 'course_score_form.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.course});

  final Course course;

  void _addScore(BuildContext context) async {
    CourseScore? newScore = await Navigator.of(context).push<CourseScore>(
      MaterialPageRoute(builder: (ctx) => const CourseScoreForm()),
    );

    if (newScore != null) {
      Provider.of<CourseProvider>(context, listen: false)
          .addScore(course.id.toString(), newScore);
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          course.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () => _addScore(context), icon: const Icon(Icons.add)),
        ],
      ),
      body: Consumer<CourseProvider>(
        builder: (context, courseProvider, child) {
          final scores = courseProvider.getScores(course.id.toString());

          if (scores.isEmpty) {
            return const Center(child: Text('No Scores added yet.'));
          }

          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (ctx, index) => ListTile(
              title: Text(scores[index].studentName),
              trailing: Text(
                scores[index].studenScore.toString(),
                style: TextStyle(
                  color: scoreColor(scores[index].studenScore),
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
