import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/home.dart';
import 'package:frontend/user_register.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final List<String> ereaItems = [
    '1丁目',
    '2丁目',
    '3丁目',
    '4丁目',
  ];
  String? selectedValue;

  final List<String> teamItems = ['第1班', '第2班', '第3班', '第4班', '第5班'];

  String? secondSelectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.grey[50], actions: [
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
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.assignment, size: 50),
            Text('TEAM HAW.',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            Container(
              margin: EdgeInsets.fromLTRB(50, 50, 50, 15),
              child: _dropDownList(ereaItems, selectedValue, '地区を選択してください'),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(50, 15, 50, 50),
              child: _dropDownList(teamItems, selectedValue, '町内会を選択してください'),
            ),
            SizedBox(
              height: 40,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserRegisterPage()),
                    );
                  },
                  child: Text(
                    '連携せずにログイン',
                    style: TextStyle(color: Colors.black54),
                  )),
            ),
            _snsButton("LINE", 0xff06c755),
            const SizedBox(height: 20),
            _snsButton("Facebook", 0xff3b5998),
            const SizedBox(
              height: 30,
            ),
            Link(
              // 開きたいWebページのURLを指定
              uri: Uri.parse('https://line.me/R/'),
              // targetについては後述
              target: LinkTarget.blank,
              builder: (BuildContext ctx, FollowLink? openLink) {
                return TextButton(
                  onPressed: openLink,
                  child: const Text(
                    'Webサイト表示',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    // minimumSize:zw
                    //     MaterialStateProperty.all(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
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
        onPressed: () async {
          print(dotenv.env['APPLICATION_ID']);
        },
        child: Text('${snsName}で連携'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(color))),
      ));
}

//カスタマイズ可能なドロップダウンのWidget
Widget _dropDownList(
    List<String> itemList, String? selectedValue, String explainText) {
  return DropdownButtonFormField2(
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
    isExpanded: true,
    hint: Text(
      '${explainText}',
      style: TextStyle(fontSize: 14),
    ),
    icon: const Icon(
      Icons.arrow_drop_down,
      color: Colors.black45,
    ),
    iconSize: 30,
    buttonHeight: 50,
    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
    dropdownDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7),
    ),
    items: itemList
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
        .toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select gender.';
      }
    },
    onChanged: (value) {
      //Do something when changing the item if you want.
    },
    onSaved: (value) {
      selectedValue = value.toString();
    },
  );
}
