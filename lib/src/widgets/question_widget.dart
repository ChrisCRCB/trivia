import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:open_trivia_db/open_trivia_db.dart';

import 'labelled_card.dart';

/// The unescape converter to use.
final unescape = HtmlUnescape();

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
    final answers = List<String>.from(question.answers)..shuffle();
    final categoryName = unescape.convert(question.categoryName);
    final questionText = unescape.convert(question.question);
    final fullText = '$categoryName. $questionText';
    return Column(
      children: [
        Focus(
          autofocus: true,
          focusNode: questionTextFocusNode,
          child: LabelledCard(
            label: fullText,
            child: Center(
              child: Text(fullText),
            ),
          ),
        ),
        Row(
          children: answers
              .map(
                (final answer) => InkWell(
                  child: LabelledCard(
                    label: answer,
                    child: Text(answer),
                  ),
                  onTap: () => onAnswer(answer),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
