import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  ImagePicker picker = ImagePicker();

  Future<void> getImageFromGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,  //背景透明
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('新規登録', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 30),
              GestureDetector(  //CircleAvatarを押せるようにする
                onTap: (){
                  getImageFromGallery();
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
                  onPressed: (){
                    if(nameController.text.isNotEmpty && userIdController.text.isNotEmpty && selfIntroductionController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && image != null){
                      Navigator.pop(context);
                    }},
                  child: Text('アカウントを作成')),
            ],
          ),
        ),
      ),
    );
  }
}
