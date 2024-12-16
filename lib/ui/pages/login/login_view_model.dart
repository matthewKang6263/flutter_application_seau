import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';

class LoginViewModel extends StateNotifier<AppUser?> {
  LoginViewModel(this._userRepository) : super(null);

  final UserRepository _userRepository;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // 로그인 메서드
  Future<void> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final user = await _userRepository.getUser(userCredential.user!.uid);
        if (user != null) {
          state = user;
        } else {
          throw Exception('사용자 정보를 찾을 수 없습니다.');
        }
      }
    } on auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // 로그아웃 메서드
  Future<void> logout() async {
    await _auth.signOut();
    state = null;
  }

  // 현재 로그인된 사용자 정보 가져오기
  Future<void> getCurrentUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final user = await _userRepository.getUser(currentUser.uid);
      if (user != null) {
        state = user;
      }
    }
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AppUser?>((ref) {
  return LoginViewModel(ref.watch(userRepositoryProvider));
});

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository());
