import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_world/ui/screens/base_screen.dart';
import 'package:movie_world/ui/screens/login_screen.dart';
import 'package:movie_world/utils/settings.dart';
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
    checkUser();
  }

  _startTimer() async {
    Timer(const Duration(seconds: 2), () async {
      var alreadyLogged = await checkUser();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => alreadyLogged ? LoginScreen() : BaseScreen()));
    });
  }

  Future<bool> checkUser() async {
    var token = await Settings.getAccessToken();
    if (token != null) {
      return true;
    } else {
      return false;
    }
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
