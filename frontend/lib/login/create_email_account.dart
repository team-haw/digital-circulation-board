import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/account.dart';
import 'package:frontend/utils/authentication.dart';
import 'package:frontend/utils/firestore/users.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/function_utils.dart';
import '../utils/widget_utils.dart';

class CreateEmailAccountPage extends StatefulWidget {
  const CreateEmailAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateEmailAccountPage> createState() => _CreateEmailAccountPageState();
}

class _CreateEmailAccountPageState extends State<CreateEmailAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  File? image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppbar('新規登録'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 30),
              GestureDetector(  //CircleAvatarを押せるようにする
                onTap: () async {
                  var result = await FunctionUtils.getImageFromGallery();
                  if(result != null){
                    setState((){
                      image = File(result.path);
                    });
                  }
                  },
                child: CircleAvatar(
                  foregroundImage: image == null ? null : FileImage(image!),
                  //画像が空かそうじゃないかで分岐　↑　
                  radius: 40,
                  child: Icon(Icons.add),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: '名前'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: userIdController,
                    decoration: InputDecoration(hintText: 'ユーザーID'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: selfIntroductionController,
                    decoration: InputDecoration(hintText: '自己紹介'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: 'メアド'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(hintText: 'パスワード'),
                  ),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () async {
                    if(nameController.text.isNotEmpty && userIdController.text.isNotEmpty && selfIntroductionController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && image != null){
                      var result = await Authentication.emailSignUp(email: emailController.text, password: passwordController.text);
                      if(result is UserCredential) {  //authentication.dart の
                        String imagePath = await FunctionUtils.uploadImage(result.user!.uid, image!);
                        Account newAccount = Account(
                          id: result.user!.uid,
                          name: nameController.text,
                          userId: userIdController.text,
                          selfIntroduction: selfIntroductionController.text,
                          imagePath: imagePath,
                        );
                        var _result = await UserFirestore.setUser(newAccount);
                        if(_result == true) {
                          Navigator.pop(context);
                        }
                      }
                    }
                    },//test2@test.jp
                  child: Text('アカウントを作成')),
            ],
          ),
        ),
      ),
    );
  }
}
