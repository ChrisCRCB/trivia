import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'play_sound_semantics.dart';

/// A menu item with the same select sound.
class SoundMenuItem extends StatelessWidget {
  /// Create an instance.
  const SoundMenuItem({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Build the widget.
  @override
  Widget build(final BuildContext context) =>
      PlaySoundSemantics(assetPath: Assets.sounds.select, child: child);
}
