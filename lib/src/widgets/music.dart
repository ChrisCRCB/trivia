import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// A widget which plays an [assetPath].
class Music extends StatefulWidget {
  /// Create an instance.
  const Music({
    required this.assetPath,
    required this.child,
    this.volume = 0.3,
    super.key,
  });

  /// The asset path to play.
  final String assetPath;

  /// The widget below this widget in the tree.
  final Widget child;

  /// The volume to use for the music.
  final double volume;

  /// Create state for this widget.
  @override
  MusicState createState() => MusicState();
}

/// State for [Music].
class MusicState extends State<Music> {
  /// The audio player to use.
  late final AudioPlayer audioPlayer;

  /// Initialise state.
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer()
      ..setReleaseMode(ReleaseMode.loop)
      ..setVolume(widget.volume)
      ..play(AssetSource(widget.assetPath));
  }

  /// Dispose of the widget.
  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) => widget.child;
}
