import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';
import 'package:open_trivia_db/open_trivia_db.dart';
import 'package:recase/recase.dart';

import '../widgets/sound_menu_item.dart';

/// A screen for selecting a [QuestionDifficulty].
class SelectQuestionDifficultyScreen extends StatelessWidget {
  /// Create an instance.
  const SelectQuestionDifficultyScreen({
    required this.onDone,
    super.key,
  });

  /// The function to call with a new difficulty.
  final void Function(QuestionDifficulty difficulty) onDone;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    const difficulties = QuestionDifficulty.values;
    return SimpleScaffold(
      title: 'Select Difficulty',
      body: ListView.builder(
        itemBuilder: (final context, final index) {
          final value = difficulties[index];
          return SoundMenuItem(
            child: ListTile(
              autofocus: value == QuestionDifficulty.medium,
              title: Text(value.name.titleCase),
              onTap: () => onDone(value),
            ),
          );
        },
        itemCount: difficulties.length,
      ),
    );
  }
}
