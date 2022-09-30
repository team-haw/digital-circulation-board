import 'package:flutter/material.dart';
import 'package:frontend/home.dart';
import 'package:dio/dio.dart';
import 'email_login.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  //　TODO: 型定義
  List<String> organizationsName = [];
  List<String> stateOrganizationsName = [];

  double _fontSizeRatio = 1;

  fetchList() async {
    final dio = Dio();
    const url =
        'https://api.airtable.com/v0/appG0X7Egx1XCDWkr/organizations?api_key=keyrmU6zPEdCXGPXv';
    var response = await dio.get(url);
    try {
      final data = response.data;
      setState(() {
        for (var i = 0; i < data["records"].length; i++) {
          organizationsName
              .add(data["records"][i]["fields"]["organization_name"]);
        }
        stateOrganizationsName = organizationsName;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EmailLoginPage(data: stateOrganizationsName)),
        );
      });
    } catch (e) {
      print(e);
    }
    ;
  }

  void _changeSliderValue(double value) {
    setState(() {
      _fontSizeRatio = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white10, actions: [
        IconButton(
            color: Colors.black,
            icon: Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return SimpleDialog(
                    title: Row(children: [
                      Text("×${_fontSizeRatio}"),
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
                      ),
                    ]),
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 30,
                          ),
                          child: Text(
                              style: TextStyle(fontSize: 20 * _fontSizeRatio),
                              'ゲストでログインの場合は掲示板のみ閲覧可能です。')),
                      SimpleDialogOption(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.close),
                      ),
                    ],
                  );
                },
              );
            })
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.assignment, size: 50),
            Text('TEAM HAW.',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 100),
/*             SizedBox(
              width: 400,
              child: _dropDownList(ereaItems, selectedValue, '地区を選択してください'),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
              child: _dropDownList(teamItems, selectedValue, '町内会を選択してください'),
            ),
            const SizedBox(height: 30) ,
            const SizedBox(height: 30),*/
            SizedBox(
              height: 40,
              child: OutlinedButton(
                  onPressed: () {
                    fetchList();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.5),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'ログイン',
                    style: GoogleFonts.notoSansJavanese(
                        color: Color(0xdd000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  )),
            ),
            /* const SizedBox(height: 50),
            _snsButton("LINE", 0xff06c755),
            const SizedBox(height: 20),
            _snsButton("Facebook", 0xff3b5998), */
            SizedBox(height: 40),
            SizedBox(
              height: 40,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Text(
                    'ゲストでログイン',
                    style: GoogleFonts.yuseiMagic(color: Colors.black87),
                  )),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

Widget _appBar(BuildContext context) {
  return AppBar(elevation: 0, backgroundColor: Colors.white10, actions: [
    IconButton(
        color: Colors.black,
        icon: Icon(Icons.help_outline),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return SimpleDialog(
                title: Text("このダイアログは説明です"),
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 30,
                      ),
                      child: Text(style: TextStyle(), 'ここに説明文が入るリマス')),
                  SimpleDialogOption(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                ],
              );
            },
          );
        })
  ]);
}

//影付きのボタンのWidget
/*
colorは0x[透明度][R][G][B]と記述　
ex) 0xffffffff -> 真っ白
*/
Widget _snsButton(String snsName, int color) {
  return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => {},
        child: Text('${snsName}でログイン'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(color))),
      ));
}

Widget createProgressIndicator() {
  return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: Colors.green,
      ));
}
