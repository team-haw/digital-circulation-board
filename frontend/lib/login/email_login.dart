import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/authentication.dart';
import '../home.dart';
import 'create_email_account.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class EmailLoginPage extends StatefulWidget {
  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();

  final List<String> data;

  const EmailLoginPage({required this.data});
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String selectedValue = '行仁町二丁目';

  late List<String> state;

  @override
  void initState() {
    super.initState();
    state = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, //背景透明
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Emailでログイン', style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Flutterラボ SNS',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              _inputForm(emailController, 'メールアドレス'),
              _inputForm(passwordController, 'パスワード'),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: 'アカウントを作成していない方は'),
                    TextSpan(
                        text: 'こちら',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateEmailAccountPage()));
                          }),
                  ],
                ),
              ),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: () async {
                  var result = await Authentication.emailSignIn(
                      email: emailController.text,
                      password: passwordController.text);
                  if (result == true) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                    //pushReplacement = このページに戻れなくする
                  }
                },
                child: Text('emailでログイン'),
              ),
              _dropDownList(state, selectedValue, "町内会を選択してください。"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _inputForm(TextEditingController? controller, String hintText) {
  return Container(
    width: 300,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    ),
  );
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
