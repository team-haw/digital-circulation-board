import 'package:flutter/material.dart';

Widget BulletinBoard(double ratio) {
  return Center(
      child: Column(
    children: [
      Icon(Icons.assignment, size: 20 * ratio),
    ],
  ));
}
