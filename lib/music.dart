import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'player_manager.dart'; 

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  PlayerManager _playerManager = PlayerManager();
  MusicItem? _currentlyPlayingItem;
  List<MusicItem> searchResults = [];
  bool showNoResults = false;

  void _playVideo(String videoId) {
    setState(() {
      if (_playerManager.controller == null) {
        _playerManager.initializeController(videoId);
      } else {
        _playerManager.controller?.load(videoId);
      }
      _currentlyPlayingItem = musicItems.firstWhere((item) => item.videoId == videoId);
    });
  }

  void _showVideoDialog(String videoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String query = '';
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Search', style: TextStyle(color: Colors.white)),
          content: TextField(
            onChanged: (value) {
              query = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter song or artist',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
                _searchMusic(query);
              },
              child: Text('Search', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _searchMusic(String query) {
    setState(() {
      searchResults = musicItems.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase()) ||
               item.subtitle.toLowerCase().contains(query.toLowerCase());
      }).toList();
      showNoResults = searchResults.isEmpty;
    });

    if (searchResults.isEmpty) {
      _showNoResultsSnackBar(query);
    }
  }

  void _showNoResultsSnackBar(String query) {
    final snackBar = SnackBar(
      content: Text('No results found for "$query"'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trending Music',
          style: TextStyle(
            fontFamily: 'CustomFont',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black, 
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: searchResults.isEmpty ? musicItems.length : searchResults.length,
                itemBuilder: (context, index) {
                  final item = searchResults.isEmpty ? musicItems[index] : searchResults[index];
                  return GestureDetector(
                    onTap: () {
                      _playVideo(item.videoId);
                    },
                    child: Card(
                      color: Colors.grey[900], 
                      elevation: 3,
                      margin: EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0), 
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0), 
                                ),
                                child: Image.asset(
                                  item.imagePath,
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white, 
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                item.subtitle,
                                style: TextStyle(fontSize: 14, color: Colors.white), 
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(Icons.play_circle_outline, color: Colors.white, size: 30),
                              onPressed: () {
                                _showVideoDialog(item.videoId);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_currentlyPlayingItem != null && _playerManager.controller != null)
              Container(
                color: Colors.black,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    YoutubePlayer(
                      controller: _playerManager.controller!,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        print('Player is ready.');
                      },
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          _currentlyPlayingItem?.imagePath ?? '',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currentlyPlayingItem?.title ?? '',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                _currentlyPlayingItem?.subtitle ?? '',
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.play_arrow, color: Colors.white),
                          onPressed: () {
                            _playerManager.controller?.play();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.pause, color: Colors.white),
                          onPressed: () {
                            _playerManager.controller?.pause();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MusicItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final String videoId;

  MusicItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.videoId,
  });
}

// Dummy data for music items
List<MusicItem> musicItems = [
  MusicItem(
    title: 'Location Unknown ◐ (feat. BEKA) (Brooklyn Session)',
    subtitle: 'Honne, Beka',
    imagePath: 'assets/images/music1.jpeg',
    videoId: 'btIQvYcLNoI', 
  ),
  MusicItem(
    title: 'Saturn',
    subtitle: 'SZA',
    imagePath: 'assets/images/music2.jpeg',
    videoId: 'V2G8ESoDXm8', 
  ),
  MusicItem(
    title: 'Sofia',
    subtitle: 'Clairo',
    imagePath: 'assets/images/music3.jpeg',
    videoId: 'rO3gFl32JeE', 
  ),
  MusicItem(
    title: 'Radio',
    subtitle: 'Lana Del Rey',
    imagePath: 'assets/images/music4.jpeg',
    videoId: '7leEmq6EMMs', 
  ),
  MusicItem(
    title: 'Traitor',
    subtitle: 'Olivia Rodrigo',
    imagePath: 'assets/images/music5.jpeg',
    videoId: '6tsu2oeZJgo', 
  ),
  MusicItem(
    title: 'Mean It',
    subtitle: 'Lauv & Lany',
    imagePath: 'assets/images/music6.jpg',
    videoId: 'c_10qS7amjk', 
  ),
  MusicItem(
    title: 'Adore You',
    subtitle: 'Harry Styles',
    imagePath: 'assets/images/music7.jpg',
    videoId: 'VF-r5TtlT9w', 
  ),
  MusicItem(
    title: 'Mine',
    subtitle: 'Bazzi',
    imagePath: 'assets/images/music8.jpg',
    videoId: 'Gc71AmT_b2k', 
  ),
  MusicItem(
    title: 'Television / So Far So Good',
    subtitle: 'Rex Orange County',
    imagePath: 'assets/images/music9.jpg',
    videoId: 'NZc__Hhi4L8', 
  ),
  MusicItem(
    title: 'Photograph',
    subtitle: 'Ed Sheeran',
    imagePath: 'assets/images/music10.jpg',
    videoId: 'nSDgHBxUbVQ', 
  ),
];
