import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 로그인 메서드
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // 에러 없음
    } on FirebaseAuthException catch (e) {
      return e.message; // 에러 메시지 반환
    }
  }
}
