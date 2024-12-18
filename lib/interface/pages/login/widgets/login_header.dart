import 'package:flutter/material.dart';

// 로그인 헤더 위젯
class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // "로그인 하세요" 텍스트 표시
    return const Text(
      "로그인 하세요",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
