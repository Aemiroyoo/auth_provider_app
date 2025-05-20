import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Hasil Quiz")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Skor kamu:", style: TextStyle(fontSize: 24)),
            Text(
              "${quiz.score} / ${quiz.questions.length}",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Ulangi Quiz"),
              onPressed: () {
                quiz.reset();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => QuizScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
