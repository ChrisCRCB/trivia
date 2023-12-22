import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// A widget that plays a sound from [assetPath] when focused.
class PlaySoundSemantics extends StatefulWidget {
  /// Create an instance.
  const PlaySoundSemantics({
    required this.assetPath,
    required this.child,
    super.key,
  });

  /// The asset path of the sound to play.
  final String assetPath;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Create state for this widget.
  @override
  PlaySoundSemanticsState createState() => PlaySoundSemanticsState();
}

/// State for [PlaySoundSemantics].
class PlaySoundSemanticsState extends State<PlaySoundSemantics> {
  /// The audio players to use.
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

  /// Build a widget.
  @override
  Widget build(final BuildContext context) => Semantics(
        onDidGainAccessibilityFocus: play,
        onDidLoseAccessibilityFocus: stop,
        child: widget.child,
      );

  /// Play the sound.
  Future<void> play() async {
    await _audioPlayer.play(AssetSource(widget.assetPath));
  }

  /// Stop playing the sound.
  Future<void> stop() async {
    await _audioPlayer.stop();
  }
}
