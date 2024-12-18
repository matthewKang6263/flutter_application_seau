import 'package:flutter/material.dart';
import 'package:flutter_application_seau/interface/pages/welcome/widgets/welcome_background.dart.dart';
import 'package:flutter_application_seau/interface/pages/welcome/widgets/welcome_buttons.dart.dart';
import 'package:flutter_application_seau/interface/pages/welcome/widgets/welcome_logo.dart.dart';
import 'package:flutter_application_seau/interface/pages/welcome/widgets/welcome_terms.dart.dart';

/// 웰컴 페이지 위젯
/// 사용자가 앱을 처음 실행했을 때 보여지는 화면
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 위젯
          WelcomeBackground(),
          // 메인 컨텐츠를 포함하는 컬럼
          Column(
            children: [
              Spacer(), // 상단 여백
              WelcomeLogo(), // 로고 위젯
              Spacer(), // 로고와 버튼 사이 여백
              WelcomeButtons(), // 가입하기, 로그인하기 버튼 위젯
              SizedBox(height: 50), // 버튼과 약관 사이 여백
              WelcomeTerms(), // 약관 동의 텍스트 위젯
            ],
          ),
        ],
      ),
    );
  }
}
