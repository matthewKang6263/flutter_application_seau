import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 인증 서비스 클래스
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository = UserRepository();

  // 현재 로그인된 유저 정보 가져오기
  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await _userRepository.getUser(user.uid);
    }
    return null;
  }

  // 이메일로 로그인
  Future<AppUser?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return await _userRepository.getUser(userCredential.user!.uid);
      }
      return null;
    } catch (e) {
      print('로그인 오류: $e');
      return null;
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
