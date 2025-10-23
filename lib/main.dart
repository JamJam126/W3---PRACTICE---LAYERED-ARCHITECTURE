 
import 'package:my_first_project/data/quiz_file_provider.dart';

import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {
  QuizRepository repo = new QuizRepository('./lib/data/quiz.json');
  Quiz quiz = repo.readQuiz();

  // Quiz quiz = Quiz(questions: questions);
  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();

  repo.writeQuiz(quiz);
}
