import 'package:firebase_auth/firebase_auth.dart';

class JoinViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 회원가입 메서드
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null; // 에러 없음
    } on FirebaseAuthException catch (e) {
      return e.message; // 에러 메시지 반환
    }
  }
}
