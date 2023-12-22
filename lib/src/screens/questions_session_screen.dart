import 'package:audioplayers/audioplayers.dart';
import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:open_trivia_db/open_trivia_db.dart';

import '../../gen/assets.gen.dart';
import '../widgets/question_widget.dart';
import 'scores_screen.dart';
import 'select_question_difficulty_screen.dart';

/// The main playing screen.
class QuestionsSessionScreen extends StatefulWidget {
  /// Create an instance.
  const QuestionsSessionScreen({
    required this.questionFactory,
    this.questionDifficulty,
    this.questionCategory,
    super.key,
  });

  /// The question factory to use.
  final QuestionFactory questionFactory;

  /// The question difficulty to use.
  final QuestionDifficulty? questionDifficulty;

  /// The question category to get questions from.
  final QuestionCategory? questionCategory;

  /// Create state for this widget.
  @override
  QuestionsSessionScreenState createState() => QuestionsSessionScreenState();
}

/// State for [QuestionsSessionScreen].
class QuestionsSessionScreenState extends State<QuestionsSessionScreen> {
  /// The audio player to use.
  late final AudioPlayer _audioPlayer;

  /// The focus node for the question text.
  late final FocusNode questionTextFocusNode;

  /// The difficulty of questions to present.
  QuestionDifficulty? questionDifficulty;

  /// The questions to show.
  List<Question>? loadedQuestions;

  /// The index of the current question.
  late int questionIndex;

  /// How many questions have been answered correctly.
  late int correctAnswers;

  /// How many questions have been answered incorrectly.
  late int incorrectAnswers;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    questionTextFocusNode = FocusNode();
    questionDifficulty = widget.questionDifficulty;
    questionIndex = 0;
    correctAnswers = 0;
    incorrectAnswers = 0;
  }

  /// Dispose of the widget.
  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
    questionTextFocusNode.dispose();
  }

  /// Play a sound from [assetPath].
  Future<void> playSound(final String assetPath) async {
    await _audioPlayer.play(AssetSource(assetPath));
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final difficulty = questionDifficulty;
    if (difficulty == null) {
      return SelectQuestionDifficultyScreen(
        onDone: (final difficulty) {
          playSound(Assets.sounds.activate);
          setState(() => questionDifficulty = difficulty);
        },
      );
    }
    final questions = loadedQuestions;
    if (questions == null) {
      getQuestions(difficulty);
      return const LoadingScreen();
    }
    if (questionIndex >= questions.length) {
      return ScoresScreen(
        correctAnswers: correctAnswers,
        incorrectAnswers: incorrectAnswers,
      );
    }
    final question = questions[questionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${questionIndex + 1} of ${questions.length}'),
      ),
      body: QuestionWidget(
        question: question,
        onAnswer: (final answer) async {
          if (answer == question.answers.first) {
            await playSound(Assets.sounds.correct);
            correctAnswers++;
          } else {
            incorrectAnswers++;
            await showMessage(
              context: context,
              message:
                  'Sorry, the correct answer was ${question.answers.first}.',
              title: 'Wrong',
            );
          }
          questionTextFocusNode.requestFocus();
          setState(() {
            questionIndex++;
          });
        },
        questionTextFocusNode: questionTextFocusNode,
      ),
      bottomSheet: Focus(
        child: Text(
          'Correct answers: $correctAnswers\n'
          'Incorrect answers: $incorrectAnswers',
        ),
      ),
    );
  }

  /// Load the questions to show.
  Future<void> getQuestions(final QuestionDifficulty difficulty) async {
    final questions = await widget.questionFactory.getQuestions(
      difficulty: difficulty,
      category: widget.questionCategory,
    );
    setState(() {
      loadedQuestions = questions;
    });
  }
}
