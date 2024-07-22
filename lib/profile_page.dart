import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, dynamic>> posts = [
    {
      'content': 'This app is dedicated to teenagers who want to experience life in the world of Gossip Girl.',
      'likes': 120,
      'comments': 45,
      'shares': 30,
    },
    {
      'content': 'You can share the hot news you have, listen to songs just like Serena and Blair\'s favorites, and watch exclusive Gossip Girl videos.',
      'likes': 95,
      'comments': 30,
      'shares': 25,
    },
    {
      'content': 'So you know you love me, XOXO Gossip Girls.',
      'likes': 150,
      'comments': 60,
      'shares': 40,
    },
  ];

  String name = 'Aisyah Fatimah';
  String field = 'Mobile Development';
  String profileImage = 'assets/images/myprofile.jpg';

  void _editProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => setState(() => name = value),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Field'),
                onChanged: (value) => setState(() => field = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editPost(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Post'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Content'),
            controller: TextEditingController(text: posts[index]['content']),
            onChanged: (value) => posts[index]['content'] = value,
          ),
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profileImage),
                  ),
                  SizedBox(height: 20),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    field,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '121 posts . 1M Likes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _editProfile,
                    child: Text('Edit Profile'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'My Posts',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 300, 
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Ionicons.ellipsis_horizontal_circle_outline, size: 20),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Options'),
                                              actions: [
                                                TextButton(
                                                  child: Text('Edit'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _editPost(index);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Delete'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _deletePost(index);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        posts[index]['content'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Ionicons.heart_outline, color: Colors.red, size: 20),
                                        SizedBox(width: 5),
                                        Text('${posts[index]['likes']}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Ionicons.chatbubble, size: 20),
                                        SizedBox(width: 5),
                                        Text('${posts[index]['comments']}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Ionicons.share_social, size: 20),
                                        SizedBox(width: 5),
                                        Text('${posts[index]['shares']}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
