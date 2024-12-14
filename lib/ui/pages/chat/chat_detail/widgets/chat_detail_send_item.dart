// chat_detail_send_item.dart

import 'package:flutter/material.dart';

class ChatDetailSendItem extends StatelessWidget {
  final String content;
  final DateTime dateTime;

  const ChatDetailSendItem({
    required this.content,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48), // 왼쪽에 프로필 공간만큼 여백
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, // 오른쪽 정렬
        children: [
          // 메시지 말풍선
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[100], // 보낸 메시지는 파란색 계열로
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(4), // 오른쪽 상단만 덜 둥글게
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black87, // 텍스트 색상 추가
                letterSpacing: -0.2, // 자간 조정
              ),
            ),
          ),
          SizedBox(height: 4),
          // 시간 표시 (포맷팅 메소드 추가)
          Text(
            _formatTime(dateTime),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // 시간을 보기좋게 포맷팅하는 메소드
  String _formatTime(DateTime time) {
    final hour = time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? '오후' : '오전';
    final formattedHour = (hour > 12 ? hour - 12 : hour).toString();

    return '$period $formattedHour:$minute';
  }
}
