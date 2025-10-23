import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    while (true) {
      stdout.write('Your Name: ');
      String? playerName = stdin.readLineSync();
      if (playerName == null || playerName.trim().isEmpty) break;
      
      Player currentPlayer = Player(name: playerName.toString());
      quiz.addOrUpdatePlayer(currentPlayer);
      currentPlayer.resetAnswers();

      for (var question in quiz.questions) {
        print('Question: ${question.title} - ( ${question.points} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(questionId: question.id, answerChoice: userInput);
          currentPlayer.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
          Answer answer = new Answer(questionId: question.id, answerChoice: '');
          currentPlayer.addAnswer(answer);
        }
        // print('');
      }

      int scoreInPercentage = currentPlayer.getScoreInPercentage(quiz.questions);
      int scoreInPoint = currentPlayer.getScoreInPoint(quiz.questions);

      print('${playerName}, your score in percent: $scoreInPercentage %');
      print('${playerName}, Your score in points: $scoreInPoint');

      for (var player in quiz.players) 
        print('Player: ${player.name}          Score: ${player.getScoreInPercentage(quiz.questions)}');
    }
    print('--- Quiz Finished ---');
  }
}
 