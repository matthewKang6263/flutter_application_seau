import 'package:flutter_application_seau/ui/pages/join/join_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';

class ProfileEditViewModel extends StateNotifier<AppUser?> {
  ProfileEditViewModel(this._userRepository) : super(null) {
    loadUserData();
  }

  final UserRepository _userRepository;

  // 사용자 데이터 로드
  Future<void> loadUserData() async {
    final userId = _userRepository.getCurrentUserId(); // 현재 로그인한 사용자 ID 가져오기
    final user = await _userRepository.getUser(userId);
    state = user;
  }

  // 프로필 업데이트 메서드
  Future<void> updateUserProfile({required String userId, String? nickname, String? location}) async {
    final updatedFields = <String, dynamic>{};
    if (nickname != null && nickname.isNotEmpty) updatedFields['nickname'] = nickname;
    if (location != null && location.isNotEmpty) updatedFields['location'] = location;

    if (updatedFields.isNotEmpty) {
      await _userRepository.updateUserFields(userId, updatedFields);
      state = state?.copyWith(nickname: nickname, location: location);
    }
  }
}

// Provider 정의
final profileEditViewModelProvider =
    StateNotifierProvider<ProfileEditViewModel, AppUser?>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return ProfileEditViewModel(userRepository);
});