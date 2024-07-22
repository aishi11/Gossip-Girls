import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FilmPage extends StatefulWidget {
  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  late YoutubePlayerController _controller;
  final List<Episode> episodes = [
    Episode(
      title: 'Serena and Blaire, Paris Vacation | Gossip Girl',
      videoId: 'Fewweawwruk',
      thumbnailUrl: 'https://img.youtube.com/vi/Fewweawwruk/0.jpg',
    ),
    Episode(
      title: 'Dan Still Has Feelings for Serena | Gossip Girl',
      videoId: 'aDPWfGH9EnI',
      thumbnailUrl: 'https://img.youtube.com/vi/aDPWfGH9EnI/0.jpg',
    ),
    Episode(
      title: 'Serena Needs To Go | Gossip Girl',
      videoId: '120n-eM-250',
      thumbnailUrl: 'https://img.youtube.com/vi/120n-eM-250/0.jpg',
    ),
    Episode(
      title: 'Upper East Side Thanksgiving | Gossip Girl',
      videoId: 'zbUk0CudTto',
      thumbnailUrl: 'https://img.youtube.com/vi/zbUk0CudTto/0.jpg',
    ),
    Episode(
      title: 'I am Chuck Bass | Gossip Girl',
      videoId: 'iQ_LEFaDeGo',
      thumbnailUrl: 'https://img.youtube.com/vi/iQ_LEFaDeGo/0.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: episodes[0].videoId ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playVideo(String? videoId) {
    if (videoId != null && videoId.isNotEmpty) {
      _controller.load(videoId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video ID is null or empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exclusive Videos',
          style: TextStyle(fontFamily: 'CustomFont', fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black, 
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                  onReady: () {
                    print('Player is ready.');
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[900],
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          episodes[index].thumbnailUrl ?? '',
                          width: 100,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        episodes[index].title ?? 'No Title',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _playVideo(episodes[index].videoId);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Episode {
  final String? title;
  final String? videoId;
  final String? thumbnailUrl;

  Episode({
    required this.title,
    required this.videoId,
    required this.thumbnailUrl,
  });
}
