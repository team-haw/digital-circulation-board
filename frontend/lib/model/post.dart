//投稿管理
class Post{
  String id;
  String content;
  String postAccountId;
  DateTime? createdTime;  //プロフィール作った時刻

  Post({this.id='', this.content='', this.postAccountId='', this.createdTime});

}