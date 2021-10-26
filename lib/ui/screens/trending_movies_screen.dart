import 'package:flutter/material.dart';
import 'package:movie_world/utils/styles.dart';

class TrendingMoviesScreen extends StatefulWidget {
  const TrendingMoviesScreen({Key? key}) : super(key: key);

  @override
  _TrendingMoviesScreenState createState() => _TrendingMoviesScreenState();
}

class _TrendingMoviesScreenState extends State<TrendingMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultDarkColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: DefaultDarkColor,
        elevation: 0,
        title: const Text(
          "Trending Movies",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
