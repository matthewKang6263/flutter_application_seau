import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/ui/pages/join/join_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';

class CertificationEditViewModel extends StateNotifier<AppUser?> {
  CertificationEditViewModel(this._userRepository) : super(null);

  final UserRepository _userRepository;


  // 사용자 데이터 로드
  Future<void> loadUserData() async {
    final userId = _userRepository.getCurrentUserId();
    final userData = await _userRepository.getUser(userId);
    state = userData;
  }

  // user getter 추가
  AppUser? get user => state;

  // 자격증 정보 업데이트
  Future<void> updateCertification(String type, String level) async {
    try {
      final userId = _userRepository.getCurrentUserId();
      await _userRepository.updateCertification(userId, type, level);
    } catch (e) {
      throw Exception('자격증 정보를 업데이트하는 중 오류가 발생했습니다: $e');
    }
  }
}

// Provider 정의
final certificationEditViewModelProvider =
    StateNotifierProvider<CertificationEditViewModel, AppUser?>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return CertificationEditViewModel(userRepository);
});