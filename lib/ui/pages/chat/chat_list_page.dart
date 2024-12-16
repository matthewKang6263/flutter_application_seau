import 'package:flutter/material.dart';
import 'package:flutter_application_seau/data/model/user.dart';
import 'package:flutter_application_seau/data/repository/chat_repository.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/chat_detail_page.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_list_view_model.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatListViewModel);
    return Scaffold(
        appBar: AppBar(
          title: Text('채팅 목록'), // 앱 바에 표시될 제목
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.chats.length,
            itemBuilder: (context, index) {
              final chat = state.chats[index];
              final otherUserId = chat.participants[0];

              return FutureBuilder<User?>(
                future: ChatRepository().getUser(otherUserId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  }

                  final user = snapshot.data!;
                  return ChatListItem(
                    sender: user.nickname,
                    message: chat.lastMessage,
                    time: _formatTime(chat.lastMessageTime),
                    imgUrl: "",
                  );
                },
              );
            }));
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
    required this.imgUrl,
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
              builder: (context) => ChatDetailPage(
                userName: sender,
                userImg: imgUrl,
              ),
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
              imgUrl: imgUrl,
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
