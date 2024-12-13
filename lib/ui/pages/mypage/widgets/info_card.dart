import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onTap;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width*0.92, // 카드의 가로 크기를 화면 너비의 92%로 설정
        constraints: BoxConstraints(
          minHeight: 135, // 카드의 최소 세로 크기를 135로 설정
        ),
        child: Card(
          color: Colors.white,
          elevation: 2, // 부드러운 그림자
          shadowColor: Colors.grey.withOpacity(0.2), // 그림자 색상 연하게
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // 내부 콘텐츠에 맞게 높이를 동적으로 조절
              children: [
                // 1. 카드 제목
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // 콘텐츠와 화살표를 세로 중앙 정렬
                  children: [
                    // 2. 콘텐츠
                    Expanded(
                      child: content,
                    ),
                    // 3. 화살표 아이콘
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}