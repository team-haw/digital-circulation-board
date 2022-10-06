import 'package:flutter/material.dart';
import 'menu/bulletin_board.dart';
import 'menu/circulation_board/time_line_page.dart';
import 'menu/profile2/profile2.dart';
import 'menu/setting.dart';
import 'menu/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectIndex = 0;
  double _fontSizeRatio = 1;

  var contentsList = [];

  void fetchList() async {
    final dio = Dio();
    const url =
        'https://api.airtable.com/v0/appG0X7Egx1XCDWkr/circulation_board?api_key=keyrmU6zPEdCXGPXv';
    var response = await dio.get(url);
    try {
      final data = response.data;
      setState(() {
        contentsList = data["records"];
      });
      print(data);
    } catch (e) {
      print(e);
    }
  }

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
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(45),
            child: AppBar(
                title: Text(
                  appBarText(_selectIndex),
                  style: GoogleFonts.dotGothic16(
                    fontSize: 20 * _fontSizeRatio,
                  ),
                ),
                backgroundColor: Color(0xFFFFFFFFF),
                actions: [
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
                ])),
        body: SingleChildScrollView(
            child: Column(children: [
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
              _bodyContent(
                  _selectIndex, _fontSizeRatio, context, fetchList(), contentsList),
            ])),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.content_paste), label: '回覧板'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: '掲示板'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'プロフィール'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
          ],
          iconSize: 25 * _fontSizeRatio,
          selectedFontSize: 14 * _fontSizeRatio,
          unselectedFontSize: 12 * _fontSizeRatio,
          currentIndex: _selectIndex,
          onTap: (value) => _onTapItem(value),
          type: BottomNavigationBarType.fixed,
        ));
  }
}

// 綺麗ではないけど全てのWidgetにratioを渡す。
// 他の方法があると思うけど、時間がかかりそうだから今はバケツリレーにする
// TODO: contentsListの型付け
Widget _bodyContent(int index, double ratio, BuildContext context, void fetch,
    dynamic contentsList) {
  switch (index) {
    case 0:
      return BulletinBoard(ratio, fetch, contentsList);
    case 1:
      return ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimeLinePage()),
            );
          },
          child: Text('掲示板へ飛ぶ'));
    case 2:
      return Profile(ratio);
    case 3:
      return Setting(context, ratio);
    default:
      return Text('error');
  }
}

// 最初はWidgetにしていたが、全てにfontStyleでratioをかけるのは綺麗じゃないし、めんどくさいのでStringにした
String appBarText(int index) {
  switch (index) {
    case 0:
      return 'xxx回覧板';
    case 1:
      return 'xxx町掲示板';
    case 2:
      return 'プロフィール';
    case 3:
      return '設定';
    default:
      return '予期せぬエラー';
  }
}
