// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const DefaultDarkColor = Color(0xff141c32);
const ButtonColor = Color(0xffe93f3f);
const ShadowColor = Color(0xffF4F1F1);

const cardDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: ShadowColor,
      blurRadius: 5.0,
      spreadRadius: 3.0,
      offset: Offset(
        0.0,
        0.0,
      ),
    )
  ],
  borderRadius: BorderRadius.all(
    Radius.circular(10.0),
  ),
);
