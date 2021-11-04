import 'package:flutter/material.dart';
import 'package:movie_world/utils/styles.dart';

class SearchBartextField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueSetter<String>? onChanged;
  const SearchBartextField({Key? key, this.controller, this.onChanged})
      : super(key: key);

  @override
  _SearchBartextFieldState createState() => _SearchBartextFieldState();
}

class _SearchBartextFieldState extends State<SearchBartextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6.0,
            spreadRadius: 0.2,
            offset: Offset(1.0, 1.0),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: DefaultDarkColor,
      ),
      child: TextFormField(
        // key: _formKey,
        style: TextStyle(color: Colors.white),
        onChanged: widget.onChanged,
        controller: widget.controller,

        decoration: InputDecoration(
          fillColor: DefaultDarkColor,
          enabled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
              )),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white, fontSize: 15.0),
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ),
      ),
    );
    ;
  }
}
