import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizProvider>(context);

    if (quiz.currentIndex >= quiz.questions.length) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ResultScreen()),
        );
      });
      return Scaffold(); // kosong dulu saat transisi
    }

    final currentQuestion = quiz.questions[quiz.currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Soal ${quiz.currentIndex + 1}/${quiz.questions.length}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              currentQuestion.question,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...List.generate(currentQuestion.options.length, (index) {
              return ListTile(
                title: Text(currentQuestion.options[index]),
                leading: Icon(Icons.circle_outlined),
                onTap: () => quiz.answer(index),
              );
            }),
          ],
        ),
      ),
    );
  }
}
