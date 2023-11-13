import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/Screen/result_screen.dart';
import 'package:quiz_app/Screen/welcome.dart';
import 'package:quiz_app/model/quastion_model.dart';

class QuizController extends GetxController {
  String name = '';
  //question variables
  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question: "who win UCL for 14 times ",
      answer: 0,
      options: ['Real Madrid', 'Fc barcelona', 'Man City', 'Fc Byren '],
    ),
    QuestionModel(
      id: 2,
      question: "Who the historical player in Ucl",
      answer: 1,
      options: ['Messi', 'CR7', 'Levandovisky', 'Bavard'],
    ),
    QuestionModel(
      id: 3,
      question: "who is the most player scoore in UCL",
      answer: 1,
      options: ['Messi', 'CR7', 'Levandovisky', 'Bavard'],
    ),
    QuestionModel(
      id: 4,
      question: "Where were the World Cup competitions held  in 2022",
      answer: 3,
      options: ['USA', 'Brazil', 'KSA', 'Qatar'],
    ),
    QuestionModel(
      id: 5,
      question: "begist stadium in spain",
      answer: 0,
      options: ['Santiago', 'Camp No', 'Ramon', 'Mestaya'],
    ),
    QuestionModel(
      id: 6,
      question: "medium stadium in spain",
      answer: 2,
      options: ['Santiago', 'Camp No', 'Ramon', 'Mestaya'],
    ),
    QuestionModel(
      id: 7,
      question: "Official sponsor of La Liga",
      answer: 0,
      options: ['Microsoft', 'Pepsi', 'Adidas', 'Santander'],
    ),
    QuestionModel(
      id: 8,
      question: "Official sponsor of Qatar2022",
      answer: 1,
      options: ['Microsoft', 'Pepsi', 'Adidas', 'Santander'],
    ),
    QuestionModel(
      id: 9,
      question: " World cup winner 2022",
      answer: 0,
      options: ['Argantina', 'France', 'Spain', 'Japan'],
    ),
    QuestionModel(
      id: 10,
      question: "Ballon d'Or winner in 2023",
      answer: 1,
      options: ['Messi', 'CR7', 'Levandovisky', 'Bavard'],
    ),
  ];

  List<QuestionModel> get questionsList => [..._questionsList];

  bool _isPressed = false;

  bool get isPressed => _isPressed; //To check if the answer is pressed

  double _numberOfQuestion = 1;

  double get numberOfQuestion => _numberOfQuestion;

  int? _selectAnswer;

  int? get selectAnswer => _selectAnswer;

  int? _correctAnswer;

  int _countOfCorrectAnswers = 0;

  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  //map for check if the question has been answered
  final Map<int, bool> _questionIsAnswerd = {};

  //page view controller
  late PageController pageController;

  //timer
  Timer? _timer;

  final maxSec = 15;

  final RxInt _sec = 15.obs;

  RxInt get sec => _sec;

  @override
  void onInit() {
    resetAnswer();
    _questionsList.shuffle(Random());
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  //get final score
  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());
    update();
  }

  //check if the question has been answered
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;

      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  //called when start again quiz
  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  //get right and wrong color
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  //het right and wrong icon
  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => _sec.value = maxSec;

  void stopTimer() => _timer!.cancel();
  //call when start again quiz
  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }
}
