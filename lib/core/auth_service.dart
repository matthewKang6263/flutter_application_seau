import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/interface/pages/join/join_view_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository;

  // UserRepository를 주입받는 생성자
  AuthService(this._userRepository);

  // 현재 로그인된 유저 정보 가져오기
  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await _userRepository.getUser(user.uid);
    }
    return null;
  }

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
    } on FirebaseAuthException catch (e) {
      print('Firebase 인증 오류: ${e.code} - ${e.message}');
      throw e;
    } catch (e) {
      print('로그인 중 알 수 없는 오류 발생: $e');
      throw Exception('로그인 중 오류가 발생했습니다.');
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 현재 인증 상태 스트림
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}

// AuthService의 Provider 정의
final authServiceProvider = Provider<AuthService>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthService(userRepository);
});
