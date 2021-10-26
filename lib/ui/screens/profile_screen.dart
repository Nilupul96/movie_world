import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_world/utils/styles.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  sendData() {
    print("2");
    http.post(Uri.parse("https://shop-app-8e293-default-rtdb.firebaseio.com/"),
        body: json.encode({
          'firstName': "Nilupul",
          'lastName': "isuru",
          'email': "hell",
        }));
    setState(() {});
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DefaultDarkColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: DefaultDarkColor,
          elevation: 0,
          title: const Text(
            "profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ElevatedButton(
          onPressed: () => sendData(),
          child: Text("data"),
        ));
  }
}
