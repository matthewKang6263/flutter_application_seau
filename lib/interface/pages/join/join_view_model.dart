import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';

class JoinViewModel extends StateNotifier<AppUser?> {
  JoinViewModel(this._userRepository) : super(null);

  final UserRepository _userRepository;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  String? _userId;
  String? _nickname;
  String? _email;
  String? _location;
  String? _certificationType;
  String? _certificationLevel;

  // 회원가입 첫 단계: 이메일, 비밀번호, 닉네임 설정
  Future<void> initiateSignUp(
      String email, String password, String nickname) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _userId = userCredential.user?.uid;
      _email = email;
      _nickname = nickname;
    } on auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // 위치 정보 설정
  void setLocation(String location) {
    _location = location;
  }

  // 자격증 정보 설정
  void setCertification(String type, String level) {
    _certificationType = type;
    _certificationLevel = level;
  }

  // 최종 회원가입 완료
  Future<void> completeSignUp() async {
    if (_userId != null &&
        _email != null &&
        _nickname != null &&
        _location != null &&
        _certificationType != null &&
        _certificationLevel != null) {
      final user = AppUser(
        id: _userId!,
        nickname: _nickname!,
        email: _email!,
        location: _location!,
        certificationType: _certificationType!,
        certificationLevel: _certificationLevel!,
        profileImageUrl: 'assets/images/default_profile_image.png', // 기본 이미지 설정
      );
      await _userRepository.createUser(user);
      state = user;
    } else {
      throw Exception('필수 정보가 모두 입력되지 않았습니다.');
    }
  }
}

final joinViewModelProvider =
    StateNotifierProvider<JoinViewModel, AppUser?>((ref) {
  return JoinViewModel(ref.watch(userRepositoryProvider));
});

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository());
