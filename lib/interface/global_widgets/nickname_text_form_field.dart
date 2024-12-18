import 'package:flutter/material.dart';

/// 닉네임 입력 필드 위젯 클래스
/// - 사용자가 닉네임을 입력할 수 있는 필드입니다.
/// - 상단에는 "닉네임" 텍스트가 표시되며, TextFormField 위젯을 사용하여 입력 필드를 제공합니다.
/// - `TextEditingController`를 통해 입력값을 제어할 수 있습니다.
/// - `validator` 함수를 통해 입력값의 유효성을 검사할 수 있습니다.
class NicknameTextFormField extends StatelessWidget {
  // 입력 필드의 값을 제어하기 위한 컨트롤러
  final TextEditingController controller;

  // 입력값의 유효성을 검사하는 함수
  final String? Function(String?)? validator;

  // 생성자: 컨트롤러를 필수로 받고, validator는 선택적으로 받습니다.
  const NicknameTextFormField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
      children: [
        // 입력 필드 위에 표시되는 텍스트
        const Text(
          "닉네임", // 텍스트 내용
          style: TextStyle(
            fontSize: 14, // 텍스트 크기
            fontWeight: FontWeight.w500, // 텍스트 두께 (중간)
            color: Colors.black87, // 텍스트 색상
          ),
        ),
        const SizedBox(height: 8), // 텍스트와 입력 필드 간의 간격
        // 닉네임 입력 필드
        TextFormField(
          // TextField에서 TextFormField로 변경
          controller: controller, // 컨트롤러를 입력 필드에 연결
          validator: validator, // validator 함수 연결
          decoration: const InputDecoration(
            // 입력 필드가 채워진 상태로 보이도록 설정
            filled: true,
            fillColor: Color(0xFFF6F6F6), // 배경색: 연한 회색
            // 입력 내용과 필드 테두리 간의 여백 설정
            contentPadding: EdgeInsets.symmetric(
              vertical: 10, // 위아래 여백
              horizontal: 12, // 좌우 여백
            ),
            // 필드 테두리 디자인 설정
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)), // 테두리 둥글게
              borderSide: BorderSide.none, // 테두리 없앰
            ),
          ),
        ),
      ],
    );
  }
}
