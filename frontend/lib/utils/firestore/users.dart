import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/utils/authentication.dart';

import '../../model/account.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _firestoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async {
    try { //うまく行ってる時
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.userId,
        'self_introduction': newAccount.selfIntroduction,
        'image_path': newAccount.imagePath,
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now(),
      });
      print('新規ユーザー作成完了');
      return true;
    } on FirebaseException catch (e) { //うまく行かない時
      print('新規ユーザー作成エラー $e');
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async {
    try{
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
        id: uid,
        name: data['name'],
        userId: data['user_id'],
        selfIntroduction: data['self_introduction'],
        imagePath: data['image_path'],
        createdTime: data['created_time'],
        updatedTime: data['updated_time'],
      );
      Authentication.myAccount = myAccount;
      print('ユーザー取得完了');
      return true;
    } on FirebaseException catch(e){
      print('ユーザー取得エラー $e');
      return false;
    }
  }
  static Future<dynamic> updateUser(Account updateAccount) async{
    try{
      await users.doc(updateAccount.id).update({
        'name' : updateAccount.name,
        'image_path' : updateAccount.imagePath,
        'user_id' : updateAccount.userId,
        'self_introduction' : updateAccount.selfIntroduction,
        'updated_time' : Timestamp.now(),
      });
      print('ユーザー情報の更新');
      return true;
    } on FirebaseException catch(e){
      print('ユーザー情報のエラー  $e');
      return false;
    }
  }
}