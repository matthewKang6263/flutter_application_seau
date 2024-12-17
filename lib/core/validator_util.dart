// lib/utils/validator_util.dart

class ValidatorUtil {
  // 이메일 유효성 검사
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요.';
    }
    // 간단한 이메일 형식 검사
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return '올바른 이메일 형식이 아닙니다.';
    }
    return null;
  }

  // 비밀번호 유효성 검사
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    if (value.length < 6) {
      return '비밀번호는 6자 이상이어야 합니다.';
    }
    return null;
  }

  // 닉네임 유효성 검사
  static String? validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    if (value.length < 2 || value.length > 10) {
      return '닉네임은 2자 이상 10자 이하여야 합니다.';
    }
    return null;
  }

  // 위치 유효성 검사
  static String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return '위치를 선택해주세요.';
    }
    return null;
  }

  // 자격증 유효성 검사
  static String? validateCertification(String? value) {
    if (value == null || value.isEmpty) {
      return '자격증을 선택해주세요.';
    }
    return null;
  }
}
