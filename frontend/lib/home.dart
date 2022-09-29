import 'package:flutter/material.dart';
import 'menu/bulletin_board.dart';
import 'menu/circulation_board/time_line_page.dart';
import 'menu/profile2.dart';
import 'menu/setting.dart';
import 'menu/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectIndex = 0;
  double _fontSizeRatio = 1;

  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void _changeSliderValue(double value) {
    setState(() {
      _fontSizeRatio = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: _AppBarText(_selectIndex), actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: Icon(Icons.home),
          ),
        ]),
        body: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text('×${_fontSizeRatio}'),
            SizedBox(
              width: 200,
              child: Slider(
                label: '×${_fontSizeRatio}',
                value: _fontSizeRatio,
                min: 0.7,
                max: 1.3,
                divisions: 4,
                onChanged: _changeSliderValue,
              ),
            )
          ]),
          _bodyContent(_selectIndex, _fontSizeRatio, context)
        ]),
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

Widget _bodyContent(int index, double ratio, BuildContext context) {
  switch (index) {
    case 0:
      return BulletinBoard(ratio);
    case 1:
      return ElevatedButton(onPressed: () {Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TimeLinePage()),
      );},child: Text('pageへ飛ぶ'));
    case 2:
      return Profile(ratio);
    case 3:
      return Setting(context);
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
