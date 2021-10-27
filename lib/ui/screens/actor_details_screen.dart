import 'package:flutter/material.dart';
import 'package:movie_world/models/cast_model.dart';
import 'package:movie_world/utils/styles.dart';

class ActorDetailsScreen extends StatefulWidget {
  final Cast actor;
  const ActorDetailsScreen({Key? key, required this.actor}) : super(key: key);

  @override
  _ActorDetailsScreenState createState() => _ActorDetailsScreenState();
}

class _ActorDetailsScreenState extends State<ActorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultDarkColor,
      appBar: AppBar(
        backgroundColor: DefaultDarkColor,
        title: Text(
          widget.actor.name!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          
        ],
      ),
    );
  }
}
