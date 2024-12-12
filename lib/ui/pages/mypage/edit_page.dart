import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/widgets/primary_button.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 전체 화면 흰색 배경
      appBar: AppBar(
        title: const Text(
          '프로필 수정',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // 그림자 제거
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // 프로필 이미지
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue[200],
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 18,
                          child: IconButton(
                            icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                            onPressed: () {
                              // 프로필 이미지 수정 로직
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // 위치 입력 필드
                const CustomTextField(
                  label: '위치',
                  hintText: '위치를 입력해주세요',
                  prefixIcon: Icons.search,
                ),
                const SizedBox(height: 25),
                // 아이디 입력 필드
                const CustomTextField(
                  label: '아이디',
                ),
                const SizedBox(height: 25),
                // 이메일 입력 필드
                const CustomTextField(
                  label: '이메일',
                  hintText: 'divinglover@gmail.com',
                  readOnly: true,
                ),
            const Spacer(), // 아래 여백 확보
                // 수정하기 버튼
                PrimaryButton(
                  text: '수정하기',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: const Color(0xFF0770E9), // 버튼 색상
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        );
  }
}

// 재사용 가능한 CustomTextField 위젯
class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final bool obscureText;
  final bool readOnly;
  final IconData? prefixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFF6F6F6),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
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