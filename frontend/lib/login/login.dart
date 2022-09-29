import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:frontend/home.dart';

import 'email_login.dart';

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
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white10, actions: [
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
            const SizedBox(height: 100),
            SizedBox(
              width: 400,
              child: _dropDownList(ereaItems, selectedValue, '地区を選択してください'),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
              child: _dropDownList(teamItems, selectedValue, '町内会を選択してください'),
            ),
            const SizedBox(height: 30),
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
                    '連携せずにログイン',
                    style: TextStyle(color: Colors.black54),
                  )),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 40,
              child: OutlinedButton(
                  onPressed: () {
                    if(DropdownButtonFormField2 != null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmailLoginPage()),
                      );}
                  },
                  child: Text(
                    'emailでログイン',
                    style: TextStyle(color: Colors.black54),
                  )),
            ),
            const SizedBox(height: 50),
            _snsButton("LINE", 0xff06c755),
            const SizedBox(height: 20),
            _snsButton("Facebook", 0xff3b5998),
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
        onPressed: () => {},
        child: Text('${snsName}でログイン'),
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

