import 'package:flutter/material.dart';

/// 웰컴 페이지의 약관 동의 텍스트를 표시하는 위젯
class WelcomeTerms extends StatelessWidget {
  const WelcomeTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60, left: 20, right: 20),
      child: Text(
        "가입시 씨유의 이용약관, 개인정보 처리방침, 쿠키사용에 동의하게 됩니다.",
        textAlign: TextAlign.center, // 텍스트 중앙 정렬
        style: TextStyle(
          fontSize: 12,
          color: Colors.white.withValues(alpha: 0.8), // 투명도 적용
        ),
      ),
    );
  }
}
