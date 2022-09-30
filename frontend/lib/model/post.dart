//投稿管理
import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String id;
  String content;
  String postAccountId;
  Timestamp? createdTime;  //プロフィール作った時刻

  Post({this.id='', this.content='', this.postAccountId='', this.createdTime});

}