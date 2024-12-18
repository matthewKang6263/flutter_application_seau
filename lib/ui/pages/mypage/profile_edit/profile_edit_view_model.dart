import 'dart:io';
import 'package:flutter_application_seau/ui/pages/join/join_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';

class ProfileEditViewModel extends StateNotifier<AppUser?> {
  ProfileEditViewModel(this._userRepository) : super(null) {
    loadUserData();
  }

  final UserRepository _userRepository;
  final ImagePicker _picker = ImagePicker();
  bool _isImageUpdated = false; // 이미지가 업데이트 됐는지 확인

  bool get isImageUpdated => _isImageUpdated;

  // 사용자 데이터 로드
  Future<void> loadUserData() async {
    try {
      final userId = _userRepository.getCurrentUserId();
      final user = await _userRepository.getUser(userId);
      state = user;
    } catch (e) {
      throw Exception('사용자 데이터를 불러오는 중 오류가 발생했습니다: $e');
    }
  }

  // 이미지 선택 및 즉시 Firebase 업로드
  Future<void> pickProfileImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final userId = _userRepository.getCurrentUserId();
        final imageUrl = await _userRepository.uploadProfileImage(userId, File(pickedFile.path));

        if (imageUrl != null) {
          // Firestore에 이미지 URL 저장
          await _userRepository.updateUser(userId, {'profileImageUrl': imageUrl});
          // 상태 업데이트
          state = state?.copyWith(profileImageUrl: imageUrl);
          _isImageUpdated = true; // 이미지를 선택하면 true로 설정
        }
      }
    } catch (e) {
      throw Exception('이미지 업로드 중 오류가 발생했습니다: $e');
    }
  }

  // 프로필 업데이트 (닉네임, 위치)
  Future<void> updateUserProfile({
    required String userId,
    String? nickname,
    String? location,
  }) async {
    final updatedFields = <String, dynamic>{};

      if (_isImageUpdated) {
      updatedFields['profileImageUrl'] = state?.profileImageUrl;
      _isImageUpdated = false; // 플래그 초기화
    }

    // 닉네임과 위치 업데이트
    if (nickname != null && nickname.isNotEmpty) updatedFields['nickname'] = nickname;
    if (location != null && location.isNotEmpty) updatedFields['location'] = location;

    if (updatedFields.isNotEmpty) {
      await _userRepository.updateUser(userId, updatedFields);
      state = state?.copyWith(
        profileImageUrl: updatedFields['profileImageUrl'] ?? state?.profileImageUrl,
        nickname: nickname ?? state?.nickname,
        location: location ?? state?.location,
      );
    } else {
      throw Exception('수정 내역이 없습니다.');
    }
  }
}

// Provider 정의
final profileEditViewModelProvider =
    StateNotifierProvider<ProfileEditViewModel, AppUser?>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return ProfileEditViewModel(userRepository);
});