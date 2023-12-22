import 'package:backstreets_widgets/extensions.dart';
import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/question_factory_builder.dart';
import 'questions_session_screen.dart';

/// The main menu for the application.
class MainScreen extends StatelessWidget {
  /// Create an instance.
  const MainScreen({
    super.key,
  });

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => QuestionFactoryBuilder(
        builder: (final context, final questionFactory) => SimpleScaffold(
          title: 'Trivia',
          body: ListView(
            children: [
              ListTile(
                autofocus: true,
                title: const Text('Play Game'),
                onTap: () => context.pushWidgetBuilder(
                  (final context) => QuestionsSessionScreen(
                    questionFactory: questionFactory,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Visit Open Trivia DB'),
                onTap: () => launchUrl(
                  Uri.parse('https://opentdb.com/api_config.php'),
                ),
              ),
            ],
          ),
        ),
        error: ErrorScreen.withPositional,
        loading: (final context) => const LoadingScreen(),
      );
}
