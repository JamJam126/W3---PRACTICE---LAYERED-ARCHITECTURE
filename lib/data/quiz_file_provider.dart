import 'dart:convert';
import 'dart:io';

import 'package:my_first_project/domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);
  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    return Quiz.fromJson(data);
  }
}
