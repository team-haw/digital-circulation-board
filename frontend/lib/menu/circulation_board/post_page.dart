import 'package:flutter/material.dart';
import 'package:frontend/utils/authentication.dart';
import 'package:frontend/utils/firestore/post.dart';

import '../../model/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新規投稿',style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: contentController, //打ってる文字が含まれている。投稿の際にそレを投稿
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  if(contentController.text.isNotEmpty){
                    Post newPost = Post (
                      content: contentController.text,
                      postAccountId: Authentication.myAccount!.id,
                    );
                    var result = await PostFireStore.addPost(newPost);
                    if(result == true){
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('投稿')
            ),
          ],
        ),
      ),
    );
  }
}
