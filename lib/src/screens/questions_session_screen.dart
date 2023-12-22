import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/util.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:open_trivia_db/open_trivia_db.dart';
import 'package:recase/recase.dart';

import '../widgets/question_widget.dart';

/// The main playing screen.
class QuestionsSessionScreen extends StatefulWidget {
  /// Create an instance.
  const QuestionsSessionScreen({
    required this.questionFactory,
    this.questionDifficulty,
    super.key,
  });

  /// The question factory to use.
  final QuestionFactory questionFactory;

  /// The question difficulty to use.
  final QuestionDifficulty? questionDifficulty;

  /// Create state for this widget.
  @override
  QuestionsSessionScreenState createState() => QuestionsSessionScreenState();
}

/// State for [QuestionsSessionScreen].
class QuestionsSessionScreenState extends State<QuestionsSessionScreen> {
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
    questionTextFocusNode.dispose();
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final difficulty = questionDifficulty;
    if (difficulty == null) {
      const difficulties = QuestionDifficulty.values;
      return SimpleScaffold(
        title: 'Select Difficulty',
        body: ListView.builder(
          itemBuilder: (final context, final index) {
            final value = difficulties[index];
            return ListTile(
              autofocus: value == QuestionDifficulty.medium,
              title: Text(value.name.titleCase),
              onTap: () => setState(() {
                questionDifficulty = value;
              }),
            );
          },
          itemCount: difficulties.length,
        ),
      );
    }
    final questions = loadedQuestions;
    if (questions == null) {
      getQuestions(difficulty);
      return const LoadingScreen();
    }
    if (questionIndex >= questions.length) {
      return SimpleScaffold(
        title: 'Results',
        body: ListView(
          children: [
            CopyListTile(
              title: 'Correct answers',
              subtitle: correctAnswers.toString(),
              autofocus: true,
            ),
            CopyListTile(
              title: 'Incorrect answers',
              subtitle: incorrectAnswers.toString(),
            ),
          ],
        ),
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
    final questions =
        await widget.questionFactory.getQuestions(difficulty: difficulty);
    setState(() {
      loadedQuestions = questions;
    });
  }
}
