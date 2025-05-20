import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider with ChangeNotifier {
  int _currentIndex = 0;
  int _score = 0;

  final List<QuestionModel> _questions = [
    QuestionModel(
      question: "Apa ibukota Indonesia?",
      options: ["Bandung", "Jakarta", "Surabaya", "Medan"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "2 + 2 = ?",
      options: ["3", "4", "5", "6"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Hewan berkaki dua?",
      options: ["Kucing", "Ayam", "Ikan", "Singa"],
      correctIndex: 1,
    ),
  ];

  int get currentIndex => _currentIndex;
  int get score => _score;
  List<QuestionModel> get questions => _questions;

  void answer(int selectedIndex) {
    if (selectedIndex == _questions[_currentIndex].correctIndex) {
      _score++;
    }
    _currentIndex++;
    notifyListeners();
  }

  void reset() {
    _score = 0;
    _currentIndex = 0;
    notifyListeners();
  }
}
