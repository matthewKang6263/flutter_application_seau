import 'package:flutter/material.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/chat_detail_page.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅 목록'), // 앱 바에 표시될 제목
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // ChatListItem을 여러 개 넣어서 채팅 목록을 만듭니다.
          ChatListItem(
            sender: '다이빙 러버',
            message: '좋습니다! 시간과 장소 모두 괜찮아요.',
            time: '오후 12:30',
          ),
          ChatListItem(
            sender: '버디버디',
            message: '오후에 만나기로 했어요!',
            time: '오후 1:00',
          ),
          ChatListItem(
            sender: '체코시당',
            message: '조금 늦을 수 있어요.',
            time: '오후 2:15',
          ),
        ],
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final String sender;
  final String message;
  final String time;

  ChatListItem({
    required this.sender,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      //
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatDetailPage();
              },
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // UserProfileImage 위젯에서 dimension 값 추가
            UserProfileImage(
              dimension: 32, // 프로필 이미지의 크기를 설정
            ),
            //
            SizedBox(width: 16),
            //
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Text(time),
          ],
        ),
      ),
    );
  }
}
