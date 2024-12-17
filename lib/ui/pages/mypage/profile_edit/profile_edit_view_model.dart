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
  File? _selectedImage;

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

  // 이미지 선택
  Future<void> pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
    }
  }

  // 프로필 업데이트 (이미지, 닉네임, 위치)
  Future<void> updateUserProfile({
    required String userId,
    String? nickname,
    String? location,
  }) async {
    final updatedFields = <String, dynamic>{};

    // 프로필 이미지 업로드
    if (_selectedImage != null) {
      final imageUrl = await _userRepository.uploadProfileImage(userId, _selectedImage!);
      if (imageUrl != null) {
        updatedFields['profileImageUrl'] = imageUrl;
      }
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