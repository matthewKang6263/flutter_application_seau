import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/global_widgets/primary_button.dart';
import 'package:flutter_application_seau/interface/pages/join/join_page.dart';
import 'package:flutter_application_seau/interface/pages/login/login_page.dart';

/// 웰컴 페이지의 가입하기, 로그인하기 버튼을 포함하는 위젯
class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          // 가입하기 버튼
          PrimaryButton(
            text: "가입하기",
            onPressed: () => _navigateTo(context, const JoinPage()),
            backgroundColor: const Color(0xFF0770E9),
          ),
          const SizedBox(height: 12), // 버튼 사이 간격
          // 로그인하기 버튼
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text(
              "로그인하기",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 지정된 페이지로 네비게이션하는 헬퍼 메서드
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
