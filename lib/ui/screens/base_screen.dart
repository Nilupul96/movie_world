import 'package:flutter/material.dart';
import 'package:movie_world/ui/screens/home_screen.dart';
import 'package:movie_world/ui/screens/profile_screen.dart';
import 'package:movie_world/ui/screens/trending_movies_screen.dart';
import 'package:movie_world/utils/styles.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const TrendingMoviesScreen(),
    const ProfileScreen(),
  ];
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultDarkColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff24243b),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.lightBlueAccent,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: "Trending"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile")
        ],
      ),
    );
  }
}
