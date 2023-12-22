import 'package:backstreets_widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_trivia_db/open_trivia_db.dart';

/// A widget which builds a question factory.
class QuestionFactoryBuilder extends StatelessWidget {
  /// Create an instance.
  const QuestionFactoryBuilder({
    required this.builder,
    required this.error,
    required this.loading,
    super.key,
  });

  /// The function to call to build the widget.
  final Widget Function(BuildContext context, QuestionFactory questionFactory)
      builder;

  /// The function to call to build an error widget.
  final Widget Function(
    Object error,
    StackTrace? stackTrace,
  ) error;

  /// The function to call to build a loading widget.
  final WidgetBuilder loading;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) {
    final future = getQuestionFactory();
    return SimpleFutureBuilder(
      future: future,
      done: (final context, final value) => builder(context, value!),
      loading: loading,
      error: error,
    );
  }

  /// Get the question factory.
  Future<QuestionFactory> getQuestionFactory() async {
    final http = Dio();
    final factory = QuestionFactory(http);
    await factory.initToken();
    return factory;
  }
}
