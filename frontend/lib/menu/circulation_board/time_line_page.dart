import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/post.dart';
import 'package:intl/intl.dart';
import '../../model/account.dart';
import 'post_page.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
      id: '1',
      name: 'Flutterラボ',
      selfIntroduction: 'こんばんは',
      userId: 'flutter_lab',
      imagePath: 'https://avatars.githubusercontent.com/u/87113276?s=40&v=4',
      createdTime: Timestamp.now(),
      updatedTime: Timestamp.now()
  );

  List<Post> postList = [
    Post(
        id: '1',
        content: '初めまして',
        postAccountId: '1',
        createdTime: DateTime.now()
    ),
    Post(
        id: '2',
        content: '初めまして2',
        postAccountId: '1',
        createdTime: DateTime.now()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('haw',style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: SizedBox(
        child: ListView.builder(
          itemCount: postList.length,
          itemBuilder: (context, index){
            return Container(
              decoration: BoxDecoration(  //一番上の投稿には上下、それ以降は下だけ線で囲う
                border: index == 0 ? Border(
                  top: BorderSide(color: Colors.grey, width: 0),
                  bottom: BorderSide(color: Colors.grey, width: 0),
                ) : Border(bottom: BorderSide(color: Colors.grey, width: 0),),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    foregroundImage: NetworkImage(myAccount.imagePath),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //左寄り
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ↑ 子たちの間に空きスペースを均等に置く。開始/終了にはスペースを設けない。
                            // 下のRowとTextに適応している。２つしかないため両端に寄る
                            children: [
                              Row(
                                children: [
                                  Text(myAccount.name, style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(myAccount.userId, style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                              Text(DateFormat('M/d/yy').format(postList[index].createdTime!)),
                            ],
                          ),
                          Text(postList[index].content),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
          },
          child: Icon(Icons.chat_bubble_outline)
      ),
    );
  }
}
