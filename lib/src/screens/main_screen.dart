import 'package:audioplayers/audioplayers.dart';
import 'package:backstreets_widgets/extensions.dart';
import 'package:backstreets_widgets/screens.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen/assets.gen.dart';
import '../widgets/question_factory_builder.dart';
import '../widgets/sound_menu_item.dart';
import 'questions_session_screen.dart';
import 'select_question_category_screen.dart';

/// The main menu for the application.
class MainScreen extends StatefulWidget {
  /// Create an instance.
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => MainScreenState();
}

/// State for [MainScreen].
class MainScreenState extends State<MainScreen> {
  /// The audio player to use.
  late final AudioPlayer _audioPlayer;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  /// Dispose of the widget.
  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  /// Play the activate sound.
  Future<void> playActivateSound() async {
    await _audioPlayer.play(AssetSource(Assets.sounds.activate));
  }

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => QuestionFactoryBuilder(
        builder: (final context, final questionFactory) => SimpleScaffold(
          title: 'Trivia',
          body: Center(
            child: ListView(
              children: [
                SoundMenuItem(
                  child: ListTile(
                    autofocus: true,
                    title: const Text('Play Game'),
                    onTap: () {
                      playActivateSound();
                      context.pushWidgetBuilder(
                        (final context) => QuestionsSessionScreen(
                          questionFactory: questionFactory,
                        ),
                      );
                    },
                  ),
                ),
                SoundMenuItem(
                  child: ListTile(
                    title: const Text('Select Question Category'),
                    onTap: () => context.pushWidgetBuilder(
                      (final context) => SelectQuestionCategoryScreen(
                        questionFactory: questionFactory,
                        onDone: (final questionCategory) =>
                            context.pushWidgetBuilder(
                          (final context) => QuestionsSessionScreen(
                            questionFactory: questionFactory,
                            questionCategory: questionCategory,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SoundMenuItem(
                  child: ListTile(
                    title: const Text('Visit Open Trivia DB'),
                    onTap: () {
                      playActivateSound();
                      launchUrl(
                        Uri.parse('https://opentdb.com/api_config.php'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        error: ErrorScreen.withPositional,
        loading: (final context) => const LoadingScreen(),
      );
}
