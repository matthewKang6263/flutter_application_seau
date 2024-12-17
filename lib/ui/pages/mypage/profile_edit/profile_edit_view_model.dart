import 'package:flutter_application_seau/ui/pages/join/join_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';

class ProfileEditViewModel extends StateNotifier<AppUser?> {
  ProfileEditViewModel(this._userRepository) : super(null);

  final UserRepository _userRepository;

  // 사용자 정보 업데이트 (변경된 값만 업데이트)
  Future<void> updateUserProfile({
    required String userId,
    String? nickname,
    String? email,
    String? location,
    String? certificationType,
    String? certificationLevel,
  }) async {
    try {
      // 업데이트할 데이터만 담는 맵 생성
      final Map<String, dynamic> updatedFields = {};

      if (nickname != null && nickname.isNotEmpty) {
        updatedFields['nickname'] = nickname;
      }
      if (email != null && email.isNotEmpty) {
        updatedFields['email'] = email;
      }
      if (location != null && location.isNotEmpty) {
        updatedFields['location'] = location;
      }
      if (certificationType != null && certificationType.isNotEmpty) {
        updatedFields['certificationType'] = certificationType;
      }
      if (certificationLevel != null && certificationLevel.isNotEmpty) {
        updatedFields['certificationLevel'] = certificationLevel;
      }

      if (updatedFields.isNotEmpty) {
        await _userRepository.updateUserFields(userId, updatedFields);

        // 상태 업데이트 (현재 상태를 기반으로 새로운 값으로 업데이트)
        state = AppUser(
          id: userId,
          nickname: nickname ?? state?.nickname ?? '',
          email: email ?? state?.email ?? '',
          location: location ?? state?.location ?? '',
          certificationType: certificationType ?? state?.certificationType ?? '',
          certificationLevel: certificationLevel ?? state?.certificationLevel ?? '',
        );
      }
    } catch (e) {
      throw Exception("프로필 업데이트에 실패했습니다: $e");
    }
  }
}

// Provider 설정
final profileEditViewModelProvider =
    StateNotifierProvider<ProfileEditViewModel, AppUser?>(
        (ref) => ProfileEditViewModel(ref.watch(userRepositoryProvider)));