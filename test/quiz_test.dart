import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

void main() {
  // Setup quiz questions
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
      points: 50
    ),
  ];

  Quiz quiz = Quiz(questions: questions);

  setUp(() {
    quiz.players.clear();
  });

  test('All correct answers test', () {
    Player player = Player(name: "TestPlayer1");

    List<String> answers = ["Paris", "4"];

    for (int i = 0; i < questions.length; i++) {
      player.addAnswer(
        Answer(questionId: questions[i].id, answerChoice: answers[i])
      );
    }

    quiz.addOrUpdatePlayer(player);

    expect(player.getScoreInPercentage(questions), equals(100));
    expect(player.getScoreInPoint(questions), equals(51)); 
  });

  test('All wrong answers test', () {
    Player player = Player(name: "TestPlayer2");

    List<String> answers = ["London", "2"];

    for (int i = 0; i < questions.length; i++) {
      player.addAnswer(
        Answer(questionId: questions[i].id, answerChoice: answers[i])
      );
    }

    quiz.addOrUpdatePlayer(player);

    expect(player.getScoreInPercentage(questions), equals(0));
    expect(player.getScoreInPoint(questions), equals(0));
  });
}
