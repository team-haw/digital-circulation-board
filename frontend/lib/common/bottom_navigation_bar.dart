import 'package:flutter/material.dart';

int _selectedIndex = 1;

Widget BottomNavBar() {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'お気に入り'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'お知らせ'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
    ],
    currentIndex: _selectedIndex,
    onTap: (value) => {_selectedIndex = value, print(_selectedIndex)},
    type: BottomNavigationBarType.fixed,
  );
}
