import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'film.dart';
import 'music.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gossip Girls',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePage(),
    MusicPage(),
    FilmPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/Lipblack.png',
              height: 50,
            ),
            SizedBox(width: 5), 
            Text(
              'Gossip Girls',
              style: TextStyle(
                fontFamily: 'CustomFont',
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 180, 22, 11),
      ),
      
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Icon(Ionicons.home, size: 25),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Icon(Ionicons.musical_notes_outline, size: 25),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Icon(Ionicons.film_outline, size: 25),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Icon(Ionicons.person, size: 25),
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 180, 22, 11),
          unselectedItemColor: const Color.fromARGB(255, 56, 55, 55),
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black, 
          showSelectedLabels: false, 
          showUnselectedLabels: false, 
        ),
    );
  }
}
