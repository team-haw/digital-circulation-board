import 'package:flutter/material.dart';
import 'package:frontend/model/post.dart';
import 'package:intl/intl.dart';
import '../../model/account.dart';
import 'post_page.dart';

class TimeLinePge extends StatefulWidget {
  const TimeLinePge({Key? key}) : super(key: key);

  @override
  State<TimeLinePge> createState() => _TimeLinePgeState();
}

class _TimeLinePgeState extends State<TimeLinePge> {
  Account myAccount = Account(
      id: '1',
      name: 'Flutterラボ',
      selfIntroduction: 'こんばんは',
      userId: 'flutter_lab',
      imagePath: 'https://careerselect.jp/imgresize/50/50/img/user/profile_15003_20220727031422.jpg',      createdTime: DateTime.now(),
      updatedTime: DateTime.now()
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
      body: ListView.builder(
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
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
          },
          child: Icon(Icons.chat_bubble_outline)
      ),
    );
  }
}
