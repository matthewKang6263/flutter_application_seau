import 'package:flutter/material.dart';

/// 웰컴 페이지의 배경 이미지를 표시하는 위젯
class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/welcome_bg.png",
      fit: BoxFit.cover, // 이미지가 전체 화면을 커버하도록 설정
      width: double.infinity, // 화면 너비 전체를 차지
      height: double.infinity, // 화면 높이 전체를 차지
    );
  }
}
