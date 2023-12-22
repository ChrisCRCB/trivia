import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../widgets/sound_menu_item.dart';

/// A screen to show scores.
class ScoresScreen extends StatelessWidget {
  /// Create an instance.
  const ScoresScreen({
    required this.correctAnswers,
    required this.incorrectAnswers,
    super.key,
  });

  /// The number of questions the player got right.
  final int correctAnswers;

  /// The number of questions the player got wrong.
  final int incorrectAnswers;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => Cancel(
        child: SimpleScaffold(
          title: 'Results',
          body: ListView(
            children: [
              SoundMenuItem(
                child: CopyListTile(
                  title: 'Correct answers',
                  subtitle: correctAnswers.toString(),
                  autofocus: true,
                ),
              ),
              SoundMenuItem(
                child: CopyListTile(
                  title: 'Incorrect answers',
                  subtitle: incorrectAnswers.toString(),
                ),
              ),
            ],
          ),
        ),
      );
}
