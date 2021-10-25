import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_world/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() async {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed("/homeScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: DefaultDarkColor,
    ));
  }
}
