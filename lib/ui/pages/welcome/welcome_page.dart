import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/join/join_page.dart';
import 'package:flutter_application_seau/ui/pages/login/login_page.dart';
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
              const Spacer(),
              // 로고 이미지
              Image.asset(
                "assets/images/logo_deepdive.png",
                width: 160,
              ),
              const Spacer(),
              // 가입하기 버튼
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
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
              const SizedBox(height: 12),
              // 로그인하기 버튼
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
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
              ),
              const SizedBox(height: 40),
              // 약관 동의 텍스트
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Text(
                  "가입시 씨유의 이용약관, 개인정보 처리방침, 쿠키사용에 동의하게 됩니다.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
