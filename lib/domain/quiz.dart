import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Question {
  // ATTRIBUTES
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  // CONSTRUCTORS
  Question({
    String? id,
    required this.title, 
    required this.choices, 
    required this.goodChoice, 
    this.points = 1
  }) : id = id ?? uuid.v4();

  Question.fromJson(Map<String, dynamic> json) : 
    id = json['id'],
    title = json['title'],
    choices = List<String>.from(json['choices']),
    goodChoice = json['goodChoice'],
    points = json['points'] ?? 1
  ;
  
  // METHOD
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'choices': choices,
    'goodChoice': goodChoice,
    'points': points,
  };
}

class Answer {
  // ATTRIBUTES
  final String id;
  final String questionId;
  final String answerChoice;

  // CONSTRUCTORS
  Answer({String? id, required this.questionId, required this.answerChoice}) : id = id ?? uuid.v4();
  Answer.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    questionId = json['questionId'],
    answerChoice = json['answerChoice']
  ;

  // METHODS
  bool isGood(Question question) => answerChoice == question.goodChoice;

  Map<String, dynamic> toJson() => {
    'id': id,
    'questionId': questionId,
    'answerChoice': answerChoice,
  };
}

class Player {
  // ATTRIBUTES
  final String id;
  final String name;
  final List<Answer> answers;

  // CONSTRUCTORS
  Player({String? id, required this.name}) : 
    id = id ?? uuid.v4(), 
    answers = []
  ;
  Player.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    answers = (json['answers'] as List? ?? []).map((a) => Answer.fromJson(a)).toList()
  ;

  // GETTER
  Answer getAnswerById(String id) => answers.firstWhere((a) => a.id == id);
    
  // METHODS
  void addAnswer(Answer answer) => answers.add(answer);
  void resetAnswers() => answers.clear();

  int getScoreInPercentage(List<Question> questions){
    int totalScore = 0;

    for(int i = 0; i < questions.length; i++) {
      if (answers[i].isGood(questions[i])) totalScore++;
    }
    
    if (questions.isEmpty) return 0;
    return ((totalScore / questions.length) * 100).toInt();
  }

  int getScoreInPoint (List<Question> questions) {
    int totalPoints = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i].isGood(questions[i])) totalPoints += questions[i].points;
    }

    return totalPoints;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'answers': answers.map((a) => a.toJson()).toList(),
  };
}

class Quiz {
  // ATTRIBUTES
  final String id;
  final List<Question> questions;
  final List<Player> players; 

  // CONSTRUCTORS
  Quiz({String? id, required this.questions}) : 
    id = id ?? uuid.v4(),
    players = []
  ;
  Quiz.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    questions = (json['questions'] as List).map((q) => Question.fromJson(q)).toList(),
    players = (json['players'] as List? ?? []).map((p) => Player.fromJson(p)).toList()
  ;

  // GETTER
  Question? getQuestionById(String id) => questions.firstWhere((q) => q.id == id);
  
  // METHODS
  void addOrUpdatePlayer(Player player) {
    int index = players.indexWhere((p) => p.name == player.name);
    
    if (index != -1) players[index] = player;
    else players.add(player);
  }
    
  Map<String, dynamic> toJson() => {
    'id': id,
    'questions': questions.map((q) => q.toJson()).toList(),
    'players': players.map((p) => p.toJson()).toList(),
  };
}