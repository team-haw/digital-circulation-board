import 'package:flutter/material.dart';

Widget Setting() {
  return Center(
      child: Column(
    children: [
      Icon(Icons.notifications),
    ],
  ));
}

Widget _button() {
  return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => {},
        child: Text('${snsName}でログイン'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(color))),
      ));
}
