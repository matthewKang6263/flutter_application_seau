import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color? borderColor;

  const PrimaryButton({
    super.key,
    required this.text,
    this.textStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ), // nullable, 텍스트스타일을 전달받지 않았을 때 정해진 스타일 사용(기본값)
    required this.onPressed,
    required this.backgroundColor,
    this.borderColor, // nullable, 기본값은 테두리 없음
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side:
              BorderSide(color: borderColor ?? Colors.transparent, width: 0.5),
        ),
        elevation: 0, // 음영 제거
      ),
      child: Text(text, style: textStyle),
    );
  }
}
