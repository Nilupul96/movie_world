import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            child: Center(
              child: Text("Movie World",
                  style: GoogleFonts.abrilFatface(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    color: Colors.white,
                  )),
            )));
  }
}
