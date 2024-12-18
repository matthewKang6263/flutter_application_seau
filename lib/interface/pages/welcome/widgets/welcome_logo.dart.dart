import 'package:flutter/material.dart';

/// 웰컴 페이지의 로고를 표시하는 위젯
class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo_deepdive.png",
      width: 160, // 로고의 너비를 160으로 설정
    );
  }
}
