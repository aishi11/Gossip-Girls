import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerManager {
  static final PlayerManager _instance = PlayerManager._internal();
  factory PlayerManager() => _instance;
  PlayerManager._internal();

  YoutubePlayerController? controller;

  void initializeController(String videoId) {
    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }
}
