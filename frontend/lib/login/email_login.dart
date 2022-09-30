import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/authentication.dart';
import '../home.dart';
import '../utils/firestore/users.dart';
import 'create_email_account.dart';

class EmailLoginPage extends StatefulWidget {
  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,  //背景透明
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
              Text('Flutterラボ SNS',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'メアド'
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'パスワード'
                  ),
                ),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: 'アカウントを作成していない方は'),
                    TextSpan(text: 'こちら',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEmailAccountPage())
                          );
                        }
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70),
              ElevatedButton(
                onPressed: () async {
                  var result = await Authentication.emailSignIn(email: emailController.text, password: passwordController.text);
                  if(result is UserCredential){
                    var _result = await UserFirestore.getUser(result.user!.uid);
                    if(_result == true){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      //pushReplacement = このページに戻れなくする
                    }
                  }
                },
                child: Text('emailでログイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
