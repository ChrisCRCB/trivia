import 'package:backstreets_widgets/screens.dart';
import 'package:backstreets_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:open_trivia_db/open_trivia_db.dart';

import '../constants.dart';
import '../widgets/sound_menu_item.dart';

/// A screen for selecting a question category.
class SelectQuestionCategoryScreen extends StatelessWidget {
  /// Create an instance.
  const SelectQuestionCategoryScreen({
    required this.questionFactory,
    required this.onDone,
    super.key,
  });

  /// The question factory to use.
  final QuestionFactory questionFactory;

  /// The function to call when the category has been selected.
  final void Function(QuestionCategory questionCategory) onDone;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    final future = questionFactory.getCategories();
    return SimpleScaffold(
      title: 'Question Categories',
      body: SimpleFutureBuilder<List<QuestionCategory>>(
        future: future,
        done: (final futureContext, final questionCategories) =>
            ListView.builder(
          itemBuilder: (final context, final index) {
            final questionCategory = questionCategories[index];
            return SoundMenuItem(
              child: ListTile(
                autofocus: index == 0,
                title: Text(unescape.convert(questionCategory.name)),
                onTap: () => onDone(questionCategory),
              ),
            );
          },
          itemCount: questionCategories!.length,
        ),
        loading: (final context) => const LoadingWidget(),
        error: ErrorListView.withPositional,
      ),
    );
  }
}
