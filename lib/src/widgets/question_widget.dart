import 'package:flutter/material.dart';
import 'package:open_trivia_db/open_trivia_db.dart';

import '../constants.dart';
import 'labelled_card.dart';
import 'sound_menu_item.dart';

/// A widget to show a single [question].
class QuestionWidget extends StatelessWidget {
  /// Create an instance.
  const QuestionWidget({
    required this.question,
    required this.onAnswer,
    required this.questionTextFocusNode,
    super.key,
  });

  /// The question to display.
  final Question question;

  /// The function to call when an answer has been selected.
  final void Function(String answer) onAnswer;

  /// The focus node to use for the question text [Card].
  final FocusNode questionTextFocusNode;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    final answers = switch (question.type) {
      QuestionType.multiple => List<String>.from(question.answers)..shuffle(),
      QuestionType.boolean => question.answers,
    };
    final categoryName = unescape.convert(question.categoryName);
    final questionText = unescape.convert(question.question);
    final fullText = '$categoryName. $questionText';
    return Column(
      children: [
        SoundMenuItem(
          child: Focus(
            autofocus: true,
            focusNode: questionTextFocusNode,
            child: LabelledCard(
              label: fullText,
              child: Center(
                child: Text(
                  fullText,
                  style: const TextStyle(fontSize: 36),
                ),
              ),
            ),
          ),
        ),
        Row(
          children: answers
              .map(
                (final answer) => SoundMenuItem(
                  child: InkWell(
                    child: LabelledCard(
                      label: answer,
                      child: Text(
                        answer,
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () => onAnswer(answer),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
