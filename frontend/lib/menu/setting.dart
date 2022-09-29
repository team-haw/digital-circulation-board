import 'package:flutter/material.dart';
import 'package:frontend/login.dart';
import '../settings/question.dart';

Widget Setting(BuildContext context) {
  final btnDataList = [
    {'text': 'プロフィール変更', 'to': QuestionPage()},
    {'text': '質問', 'to': QuestionPage()},
  ];

  return Center(
      child: Column(children: [
    for (final data in btnDataList)
      _button(context, data['text'].toString(), data['to']),
    SizedBox(height: 100),
    _button(context, 'ログアウト', LoginPage()),
  ]));
}

Widget _button(
  BuildContext context,
  String? btnText,
  final toPage,
) {
  bool isLoginBtn;
  isLoginBtn = btnText == 'ログアウト' ? true : false;

  if (btnText == null || toPage == null) {
    Text('hoge');
  }
  ;
  return SizedBox(
      width: 1000,
      height: 40,
      child: ElevatedButton(
        onPressed: () => {
          if (!isLoginBtn)
            {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => toPage))
            }
          else
            {
              showDialog(
                context: context,
                builder: (_) {
                  return SimpleDialog(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 20,
                          ),
                          child: Text(style: TextStyle(), 'ログアウトしました')),
                      // Navigator.pushをしているためLoginPageに戻るボタンが追加されてしまっている。
                      // TODO: Navigator.popでLoginPageに戻りたい
                      SimpleDialogOption(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => toPage)),
                        child: Center(child: Text('OK')),
                      )
                    ],
                  );
                },
              )
            }
        },
        child: Text('${btnText}',
            style: TextStyle(
                color: isLoginBtn ? Colors.white : Colors.black,
                fontWeight: isLoginBtn ? FontWeight.bold : FontWeight.normal)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                isLoginBtn ? Color(0xFFFF0838) : Colors.white)),
      ));
}
