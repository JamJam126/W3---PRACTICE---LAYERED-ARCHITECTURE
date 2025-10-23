 
import 'package:my_first_project/data/quiz_file_provider.dart';

import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {

  List<Question> questions = [
    Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris"    
    ),
    Question(
        title: "2 + 2 = ?", 
        choices: ["2", "4", "5"], 
        goodChoice: "4",
        points: 50,
    ),
  ];

  QuizRepository repo = new QuizRepository('./lib/data/quiz.json');
  Quiz quiz = repo.readQuiz();

  // Quiz quiz = Quiz(questions: questions);
  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();
}
