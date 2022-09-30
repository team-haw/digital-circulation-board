import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/post.dart';
import 'package:frontend/utils/firestore/post.dart';
import 'package:frontend/utils/firestore/users.dart';
import 'package:intl/intl.dart';
import '../../model/account.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('haw',style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: SizedBox(
        child: StreamBuilder<QuerySnapshot>(
          stream: PostFireStore.posts.snapshots(),
          builder: (context, postSnapshot) {
            if(postSnapshot.hasData){
              List<String> postAccountIds = [];
              postSnapshot.data!.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                if(!postAccountIds.contains(data['post_account_id'])){
                  postAccountIds.add(data['post_account_id']);
                }
              });
              return FutureBuilder<Map<String, Account>?>(
                future: UserFirestore.getPostUserMap(postAccountIds),
                builder: (context, userSnapshot) {
                  if(userSnapshot.hasData && userSnapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: postSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = postSnapshot.data!.docs[index].data() as Map<String, dynamic>;
                        Post post = Post(
                          id: postSnapshot.data!.docs[index].id,
                          content: data['content'],
                          postAccountId: data['post_account_id'],
                          createdTime: data['created_time'],
                        );
                        Account postAccount = userSnapshot.data![post.postAccountId]!;
                        return Container(
                          decoration: BoxDecoration( //一番上の投稿には上下、それ以降は下だけ線で囲う
                            border: index == 0 ? Border(
                              top: BorderSide(color: Colors.grey, width: 0),
                              bottom: BorderSide(color: Colors.grey, width: 0),
                            ) : Border(bottom: BorderSide(
                                color: Colors.grey, width: 0),),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                foregroundImage: NetworkImage(postAccount.imagePath),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, //左寄り
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        // ↑ 子たちの間に空きスペースを均等に置く。開始/終了にはスペースを設けない。
                                        // 下のRowとTextに適応している。２つしかないため両端に寄る
                                        children: [
                                          Row(
                                            children: [
                                              Text(postAccount.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),),
                                              Text(postAccount.userId,
                                                  style: TextStyle(
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                          Text(DateFormat('M/d/yy').format(
                                              post.createdTime!
                                                  .toDate())),
                                        ],
                                      ),
                                      Text(post.content),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }else{
                    return Container();
                  }
                }
              );
          } else {
              return Container();
            }
          }
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
      //     },
      //     child: Icon(Icons.chat_bubble_outline)
      // ),
    );
  }
}
