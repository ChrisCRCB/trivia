import 'package:flutter/material.dart';

/// A card with a [Semantics] [label].
class LabelledCard extends StatelessWidget {
  /// Create an instance.
  const LabelledCard({
    required this.label,
    required this.child,
    super.key,
  });

  /// The label for this card.
  final String label;

  /// The widget below the [Card] widget in the tree.
  final Widget child;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) => Semantics(
        excludeSemantics: true,
        label: label,
        child: child,
      );
}
