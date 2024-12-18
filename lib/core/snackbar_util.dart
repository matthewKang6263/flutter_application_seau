import 'package:flutter/material.dart';

class SnackbarUtil {
  // 성공 메시지 스낵바
  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.green);
  }

  // 에러 메시지 스낵바
  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.red);
  }

  // 정보 메시지 스낵바
  static void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.blue);
  }

  // 스낵바 표시 헬퍼 메서드
  static void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
    if (scaffoldMessenger != null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
