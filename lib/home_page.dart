import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Comment {
  String text;
  String profileName;
  AssetImage profileImage;
  int likes;
  int dislikes;
  bool isLiked;

  Comment({
    required this.text,
    required this.profileName,
    required this.profileImage,
    this.likes = 0,
    this.dislikes = 0,
    this.isLiked = false,
  });
}

class Post {
  String text;
  dynamic image;
  int likes;
  int commentsCount;
  int shares;
  String profileName;
  AssetImage profileImage;
  List<Comment> comments;
  bool isLiked;

  Post({
    required this.text,
    this.image,
    this.likes = 0,
    this.commentsCount = 0,
    this.shares = 0,
    required this.profileName,
    required this.profileImage,
    List<Comment>? comments,
    this.isLiked = false,
  }) : this.comments = comments ?? [];
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();
  List<Post> _posts = [];
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() { 
    super.initState();
    _posts = [
      Post(
        profileName: 'JennieRubyJane',
        text: 'Serena is back!!!',
        image: AssetImage('assets/images/post1.jpg'),
        likes: 123434,
        shares: 11232,
        commentsCount: 2231,
        profileImage: AssetImage('assets/images/profile1.jpg'),
        comments: [
          Comment(
            text: 'welcome back queen serena!',
            profileName: 'AerichanDesu',
            profileImage: AssetImage('assets/images/profile2.jpg'),
            likes: 5,
            isLiked: false,
          ),
          Comment(
            text: 'wondering how blaire gonna react',
            profileName: 'JayBNowhere',
            profileImage: AssetImage('assets/images/profile3.jpg'),
            likes: 2,
            isLiked: false,
          ),
          Comment(
            text: 'so stunning',
            profileName: 'IgotYunaandMe',
            profileImage: AssetImage('assets/images/profile4.jpg'),
            dislikes: 1,
            isLiked: false,
          ),
        ],
      ),
      Post(
        profileName: 'Nancyyy',
        text: 'periodt',
        image: AssetImage('assets/images/Mypost.jpg'),
        likes: 100,
        shares: 5,
        commentsCount: 2,
        profileImage: AssetImage('assets/images/profile5.jpg'),
        comments: [
          Comment(
            text: 'thumbs up',
            profileName: 'SophiaWang',
            profileImage: AssetImage('assets/images/profile6.jpg'),
            likes: 7,
            isLiked: false,
          ),
          Comment(
            text: 'absolutely',
            profileName: 'ShinRyuu',
            profileImage: AssetImage('assets/images/profile7.jpg'),
            likes: 3,
            isLiked: false,
          ),
        ],
      ),
    ];
  }

  void _addPost() {
    if (_postController.text.isNotEmpty || _selectedImage != null) {
      setState(() {
        _posts.add(Post(
          profileName: 'Aishiu',
          text: _postController.text,
          image: _selectedImage,
          profileImage: AssetImage('assets/images/myprofile.jpg'),
          isLiked: false,
        ));
        _postController.clear();
        _selectedImage = null;
      });
    }
  }

  void _deletePost(int index) {
    setState(() {
      _posts.removeAt(index);
    });
  }

  void _editPost(int index) {
    _postController.text = _posts[index].text;
    _selectedImage = _posts[index].image is File ? _posts[index].image : null;
    _posts.removeAt(index);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
  }

  void _copyLink() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Link copied',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color.fromARGB(255, 39, 39, 39),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 235, 230, 230),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 110.0, vertical: 10.0),
      ),
    );
  }

  void _addComment(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController commentController = TextEditingController();

        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Add Comment', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(
              hintText: 'Enter your comment',
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
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
                setState(() {
                  _posts[index].comments.add(
                    Comment(
                      text: commentController.text,
                      profileName: 'Aishiu',
                      profileImage: AssetImage('assets/images/myprofile.jpg'),
                      isLiked: false,
                    ),
                  );
                  _posts[index].commentsCount++;
                });
                commentController.clear();
                Navigator.pop(context);
              },
              child: Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, 
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Ionicons.camera, color: Colors.white),
                    onPressed: _pickImage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _postController,
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Who\'s in the spotlight now?',
                        hintStyle: TextStyle(
                          fontFamily: 'Lora',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color.fromARGB(255, 192, 191, 191),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Ionicons.send, color: Colors.white),
                          onPressed: _addPost,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(_selectedImage!),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[900], 
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: _posts[index].profileImage,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _posts[index].profileName,
                                      style: TextStyle(
                                        fontFamily: 'CustomFont',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      _posts[index].text,
                                      style: TextStyle(
                                        fontFamily: 'CustomFont',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (String result) {
                                  if (result == 'Edit') {
                                    _editPost(index);
                                  } else if (result == 'Delete') {
                                    _deletePost(index);
                                  }
                                },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Edit',
                                    child: Text('Edit', style: TextStyle(color: Colors.white)),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Delete',
                                    child: Text('Delete', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          if (_posts[index].image != null)
                            (_posts[index].image is File)
                                ? Image.file(_posts[index].image)
                                : Image(image: _posts[index].image),
                          SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Ionicons.heart,
                                  color: _posts[index].isLiked ? Colors.red : Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _posts[index].isLiked = !_posts[index].isLiked;
                                    _posts[index].likes += _posts[index].isLiked ? 1 : -1;
                                  });
                                },
                              ),
                              Text(
                                _posts[index].likes.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 16),
                              IconButton(
                                icon: Icon(Ionicons.chatbubble, color: Colors.white),
                                onPressed: () {
                                  _addComment(index);
                                },
                              ),
                              Text(
                                _posts[index].commentsCount.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 16),
                              IconButton(
                                icon: Icon(Ionicons.share_social, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _posts[index].shares++;
                                  });
                                  _copyLink();
                                },
                              ),
                              Text(
                                _posts[index].shares.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: _posts[index].comments.map((comment) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: comment.profileImage,
                                ),
                                title: Text(comment.profileName, style: TextStyle(color: Colors.white)),
                                subtitle: Text(comment.text, style: TextStyle(color: Colors.white)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Ionicons.heart,
                                        color: comment.isLiked ? Colors.red : Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          comment.isLiked = !comment.isLiked;
                                          comment.likes += comment.isLiked ? 1 : -1;
                                        });
                                      },
                                    ),
                                    Text(
                                      comment.likes.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    if (comment.dislikes > 0) ...[
                                      IconButton(
                                        icon: Icon(Ionicons.thumbs_down, color: Colors.white),
                                        onPressed: () {
                                          setState(() {
                                            comment.dislikes++;
                                          });
                                        },
                                      ),
                                      Text(
                                        comment.dislikes.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }).toList(),
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
    );
  }
}
