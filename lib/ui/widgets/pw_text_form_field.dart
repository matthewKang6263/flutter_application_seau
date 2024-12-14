import 'package:flutter/material.dart';

class PwTextFormField extends StatelessWidget {
  const PwTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "비밀번호", // 텍스트 필드 상단의 제목
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8), // 제목과 필드 간 간격
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF6F6F6), // 필드 배경색
            contentPadding: EdgeInsets.symmetric(
              vertical: 10, // 위아래 여백을 줄임 (기본값보다 작게)
              horizontal: 12, // 좌우 여백
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
