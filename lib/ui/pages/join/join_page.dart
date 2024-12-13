import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/address_search/address_search_page.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 전체 화면 흰색 배경
      appBar: AppBar(
        backgroundColor: Colors.white, // 앱바 흰색
        elevation: 0, // 그림자 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 프로그레스 바
          Stack(
            children: [
              // 전체 회색 바
              Container(
                height: 4,
                color: const Color(0xFFDDDDDD), // 회색
              ),
              // 진행 중인 파란색 바
              FractionallySizedBox(
                widthFactor: 0.33, // 현재 1/3 단계 (조정 가능 2단계는 0.66, 3단계는 1.0로 설정.)
                child: Container(
                  height: 4,
                  color: const Color(0xFF0770E9), // 파란색
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "계정을 생성하세요",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // 아이디 입력 필드
                  const CustomTextField(
                    label: "아이디",
                  ),
                  const SizedBox(height: 16),
                  // 이메일 입력 필드
                  const CustomTextField(
                    label: "이메일",
                  ),
                  const SizedBox(height: 16),
                  // 비밀번호 입력 필드
                  const CustomTextField(
                    label: "비밀번호",
                    obscureText: true,
                  ),
                  const Spacer(), // 아래 여백 확보
                  // 완료 버튼
                  PrimaryButton(
                    text: "다음",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressSearchPage(),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFF0770E9), // 기존 버튼 색상
                  ),
                  const SizedBox(height: 60), // 하단 여백
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // 텍스트 필드 상단의 제목
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8), // 제목과 필드 간 간격
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF6F6F6), // 필드 배경색
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10, // 위아래 여백을 줄임 (기본값보다 작게)
              horizontal: 12, // 좌우 여백
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
