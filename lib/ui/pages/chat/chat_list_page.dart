import 'package:flutter/material.dart';
import 'package:flutter_application_seau/data/repository/chat_repository.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/chat_detail_page.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_list_view_model.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatListViewModel);
    final currentUser = FirebaseAuth
        .instance.currentUser; // 현재 로그인한 사용자 정보 (수정된 부분!!!!!!!!!!!!!)

    return Scaffold(
      appBar: AppBar(
        title: Text('채팅 목록'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: state.chats.length,
        itemBuilder: (context, index) {
          final chat = state.chats[index];

          // participants에서 현재 사용자 제외 (수정된 부분!!!!!!!!!!!!!)
          final otherUserId = chat.participants
              .firstWhere((id) => id != currentUser?.uid, orElse: () => '');

          if (otherUserId.isEmpty)
            return SizedBox(); // 상대방 ID가 없으면 빈 위젯 반환 (수정된 부분!!!!!!!!!!!!!)

          return FutureBuilder<AppUser?>(
            future: ChatRepository().getUser(otherUserId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(); // 데이터가 없으면 빈 위젯 반환
              }

              final user = snapshot.data!;
              return ChatListItem(
                sender: user.nickname,
                message: chat.lastMessage,
                time: _formatTime(chat.lastMessageTime),
                imgUrl: user
                    .profileImageUrl, // 상대방 이미지 URL 추가 (수정된 부분!!!!!!!!!!!!!)
              );
            },
          );
        },
      ),
    );
  }
}

String _formatTime(DateTime time) {
  final hour = time.hour;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = hour >= 12 ? '오후' : '오전';
  final formattedHour = (hour > 12 ? hour - 12 : hour).toString();
  return '$period $formattedHour:$minute';
}

class ChatListItem extends StatelessWidget {
  final String sender;
  final String message;
  final String time;
  final String? imgUrl;

  ChatListItem({
    required this.sender,
    required this.message,
    required this.time,
    this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailPage(
                userName: sender,
                userImg: imgUrl, // 상대방 이미지 URL 전달 (수정된 부분!!!!!!!!!!!!!)
              ),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileImage(
              dimension: 32,
              imgUrl: imgUrl,
            ),
            SizedBox(width: 16),
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
