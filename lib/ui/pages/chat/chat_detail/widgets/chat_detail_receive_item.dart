// 받은채팅

// chat_detail_receive_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_seau/data/repository/chat_repository.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';

class ChatDetailReceiveItem extends StatefulWidget {
  // 프로필 이미지 URL, 이미지 표시 여부, 메시지 내용, 시간을 받아옵니다
  final String? userImg;
  final bool showProfile; // 연속된 메시지일 경우 프로필을 숨기기 위한 flag
  final String content;
  final DateTime dateTime;
  final String userName;
  final String senderId;

  const ChatDetailReceiveItem({
    required this.userImg,
    required this.showProfile,
    required this.content,
    required this.dateTime,
    required this.userName,
    required this.senderId,
  });

  @override
  State<ChatDetailReceiveItem> createState() => _ChatDetailReceiveItemState();
}

class _ChatDetailReceiveItemState extends State<ChatDetailReceiveItem> {
  String? senderName;
  @override
  void initState() {
    super.initState();
    _loadSenderInfo(); // 발신자 정보 로드
  }

  Future<void> _loadSenderInfo() async {
    try {
      final user = await ChatRepository().getUser(widget.senderId);
      // 데이터 확인을 위한 print문 추가
      print('Sender ID: ${widget.senderId}');
      print('Loaded user: ${user?.nickname}');

      if (user != null) {
        setState(() {
          senderName = user.nickname; // 실제 사용자 닉네임으로 설정
        });
        // setState 후 값 확인
        print('Set senderName to: $senderName');
      }
    } catch (e) {
      print('발신자 정보 로드 중 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = senderName ?? widget.userName;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // 상단 정렬
      children: [
        // 프로필 이미지나 공백
        widget.showProfile
            ? UserProfileImage(dimension: 40, imgUrl: widget.userImg)
            : SizedBox(width: 40),
        SizedBox(width: 8),

        // 메시지와 시간을 포함하는 영역
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              // 메시지 말풍선
              Container(
                constraints: BoxConstraints(maxWidth: 208),
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  // 테두리 설정
                  border: Border.all(
                    color: Colors.grey[300]!, // 테두리 색상
                    width: 1.0, // 테두리 두께
                  ),
                  // 둥근 모서리 설정 (필요한 경우)
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0), // 왼쪽 위
                    topRight: Radius.circular(16), // 오른쪽 위
                    bottomLeft: Radius.circular(16), // 왼쪽 아래
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName, // widget.userName 대신 displayName 사용
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      child: Text(
                        widget.content,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.black87,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              // 시간 표시
              Text(
                _formatTime(widget.dateTime),
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
