import 'package:flutter/material.dart';
import 'menu/bulletin_board.dart';
import 'menu/circulation_board/time_line_page.dart';
import 'menu/setting.dart';
import 'menu/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: _AppBarText(_selectIndex)),
        body: _bodyContent(_selectIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: '回覧板'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '掲示板'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'プロフィール'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
          ],
          currentIndex: _selectIndex,
          onTap: (value) => _onTapItem(value),
          type: BottomNavigationBarType.fixed,
        ));
  }
}

Widget _bodyContent(int index) {
  switch (index) {
    case 0:
      return BulletinBoard();
    case 1:
      return TimeLinePge();
    case 2:
      return Setting();
    case 3:
      return Profile();
    default:
      return Text('error');
  }
}

Widget _AppBarText(int index) {
  switch (index) {
    case 0:
      return Text('xxx回覧板');
    case 1:
      return Text('xxx町掲示板');
    case 2:
      return Text('プロフィール');
    case 3:
      return Text('設定');
    default:
      return Text('予期せぬエラー');
  }
}
