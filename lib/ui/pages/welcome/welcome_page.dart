import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/join/join_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Image.asset(
            "assets/images/welcome_bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              const Spacer(), // 상단 여백
              // 로고와 텍스트
              Column(
                children: [
                  // 로고 이미지
                  Image.asset(
                    "assets/images/logo_deepdive.png",
                    width: 160,
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(height: 40),
              // 시작하기 버튼
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: PrimaryButton(
                  text: "가입하기",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const JoinPage(),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF0770E9),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
