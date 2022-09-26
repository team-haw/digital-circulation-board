import 'package:flutter/material.dart';

class BulletinBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hoge町掲示板')),
      body: Center(
        child: Text('body'),
      ),
      /* bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            tooltip: "This is a Book Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            tooltip: "This is a Business Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            tooltip: "This is a School Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            tooltip: "This is a Settings Page",
          ),
        ],
      ), */
    );
  }
}
