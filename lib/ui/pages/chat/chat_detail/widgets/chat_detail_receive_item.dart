// 받은채팅

// chat_detail_receive_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';

class ChatDetailReceiveItem extends StatelessWidget {
  // 프로필 이미지 URL, 이미지 표시 여부, 메시지 내용, 시간을 받아옵니다
  final String imgUrl;
  final bool showProfile; // 연속된 메시지일 경우 프로필을 숨기기 위한 flag
  final String content;
  final DateTime dateTime;

  const ChatDetailReceiveItem({
    required this.imgUrl,
    required this.showProfile,
    required this.content,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // 상단 정렬
      children: [
        // 프로필 이미지나 공백
        showProfile
            ? UserProfileImage(dimension: 40, imgUrl: imgUrl)
            : SizedBox(width: 40),
        SizedBox(width: 8),

        // 메시지와 시간을 포함하는 영역
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 메시지 말풍선
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.black87,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              SizedBox(height: 4),
              // 시간 표시
              Text(
                _formatTime(dateTime),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 시간을 보기좋게 포맷팅하는 메소드
String _formatTime(DateTime time) {
  final hour = time.hour;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = hour >= 12 ? '오후' : '오전';
  final formattedHour = (hour > 12 ? hour - 12 : hour).toString();

  return '$period $formattedHour:$minute';
}
