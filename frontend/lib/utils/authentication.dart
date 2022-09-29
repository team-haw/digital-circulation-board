import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> emailSignUp({required String email, required String password}) async {
    try {  //処理がうまく行った場合
      UserCredential newAccount = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print('auth完了');
      return newAccount;
    } on FirebaseAuthException catch (e) {  //処理がうまくいかなかった場合
      print('auth登録エラー $e');
      return false;
    }
  }

  static Future<dynamic> emailSignIn({required String email, required String password}) async {
    try {  //処理がうまく行った場合
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      currentFirebaseUser = _result.user;
      print('authサインイン完了');
      return true;
    } on FirebaseAuthException catch (e) {  //処理がうまくいかなかった場合
      print('authサインインエラー$e');
      return false;
    }
  }
}