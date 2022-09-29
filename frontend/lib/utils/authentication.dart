import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> signUp(
      {required String email, required String password}) async {
    try {  //処理がうまく行った場合
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('auth完了');
      return true;
    } on FirebaseAuthException catch (e) {  //処理がうまくいかなかった場合
      print('auth登録エラー');
      return '登録エラーが発生しました';
    }
  }
}