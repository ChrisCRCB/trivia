import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// A widget which plays a sound from an [assetPath].
class PlaySound extends StatefulWidget {
  /// Create an instance.
  const PlaySound({
    required this.assetPath,
    required this.child,
    super.key,
  });

  /// The asset path to load the sound from.
  final String assetPath;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Create state for this widget.
  @override
  PlaySoundState createState() => PlaySoundState();
}

/// State for [PlaySound].
class PlaySoundState extends State<PlaySound> {
  /// The audio player to use.
  late final AudioPlayer _audioPlayer;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.play(AssetSource(widget.assetPath));
  }

  /// Dispose of the widget.
  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) => widget.child;
}
