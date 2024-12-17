import 'package:flutter_application_seau/ui/pages/join/join_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';

// 1. 클래스 생성
// 2. 뷰모델 만들기
class ProfileEditViewModel extends StateNotifier<AppUser?> {
  ProfileEditViewModel(this._userRepository) : super(null) {
    loadUserData();
  }

  final UserRepository _userRepository;
  final ImagePicker _picker = ImagePicker();

  // 사용자 데이터 로드
  Future<void> loadUserData() async {
    try {
      final userId = _userRepository.getCurrentUserId(); // 현재 로그인한 사용자 ID 가져오기
      final user = await _userRepository.getUser(userId);
      state = user;
    } catch (e) {
      throw Exception('사용자 데이터를 불러오는 중 오류가 발생했습니다: $e');
    }
  }


  // 프로필 업데이트 메서드
  Future<void> updateUserProfile({
    required String userId,
    String? nickname,
    String? location
    }) async {
    final updatedFields = <String, dynamic>{};
    if (nickname != null && nickname.isNotEmpty) updatedFields['nickname'] = nickname;
    if (location != null && location.isNotEmpty) updatedFields['location'] = location;

    if (updatedFields.isNotEmpty) {
      await _userRepository.updateUser(userId, updatedFields);
      state = state?.copyWith(nickname: nickname, location: location);
    }
  }
  
   // 이미지 선택 및 업로드 메서드
  Future<void> pickAndUploadProfileImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final userId = _userRepository.getCurrentUserId();
        final imageUrl = await _userRepository.uploadProfileImage(userId, pickedFile);

        // 상태 업데이트
        state = state?.copyWith(profileImageUrl: imageUrl);
      }
    } catch (e) {
      throw Exception('이미지 업로드 중 오류가 발생했습니다: $e');
    }
  }
}


// Provider 정의
final profileEditViewModelProvider =
    StateNotifierProvider<ProfileEditViewModel, AppUser?>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return ProfileEditViewModel(userRepository);
});