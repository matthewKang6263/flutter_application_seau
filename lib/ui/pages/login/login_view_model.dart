import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/core/auth_service.dart';

// LoginViewModel 정의
class LoginViewModel extends StateNotifier<AppUser?> {
  LoginViewModel(this._authService) : super(null);

  final AuthService _authService;

  // 로그인
  Future<bool> login(String email, String password) async {
    try {
      final user = await _authService.signIn(email, password);
      if (user != null) {
        state = user;
        return true;
      }
      return false;
    } catch (e) {
      print('로그인 실패: $e');
      return false;
    }
  }

  // 로그아웃
  Future<void> logout() async {
    await _authService.signOut();
    state = null;
  }
}

// Provider 정의
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AppUser?>((ref) {
  return LoginViewModel(ref.read(authServiceProvider));
});
