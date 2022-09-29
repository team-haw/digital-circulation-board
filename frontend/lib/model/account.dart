class Account{
  String id;
  String name;
  String imagePath;  //プロ画
  String selfIntroduction;  //自己紹介
  String userId;
  DateTime? createdTime;  //プロフィール作った時刻
  DateTime? updatedTime;  //プロフィール更新時刻

Account({this.id='', this.name='', this.imagePath='', this.selfIntroduction='', this.userId='', this.createdTime, this.updatedTime});
//Timeは?があるから'='なしでいい
}