import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_seau/data/repository/chat_repository.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_input.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_receive_item.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/widgets/chat_detail_send_item.dart';
import 'package:flutter_application_seau/ui/widgets/user_profile_image.dart';

class ChatDetailPage extends StatelessWidget {
  final String userName; // 상대방 이름
  final String? userImg; // 상대방 프로필 이미지
  final String chatId;
  final ChatRepository _chatRepository = ChatRepository();
  //
  ChatDetailPage({
    Key? key,
    required this.userName,
    this.userImg,
    required this.chatId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$userName님과의 채팅',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
            width: 1,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            // 실시간 메시지를 표시하는 영역
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _chatRepository.getChatMessages(chatId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true, // 최신 메시지가 위에 보이도록 설정
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final content = message['content'];
                      final senderId = message['senderId'];
                      final timestamp = message['timestamp'] as Timestamp?;
                      final isCurrentUser = senderId == currentUserId;

                      return isCurrentUser
                          ? ChatDetailSendItem(
                              content: content,
                              dateTime: timestamp?.toDate() ?? DateTime.now(),
                            )
                          : ChatDetailReceiveItem(
                              userImg: userImg,
                              showProfile: _shouldShowProfile(messages, index),
                              userName: userName,
                              content: content,
                              dateTime: timestamp?.toDate() ?? DateTime.now(),
                              senderId: senderId,
                            );
                    },
                  );
                },
              ),
            ),
            ChatDetailInput(chatId: chatId),
          ],
        ),
      ),
    );
  }

  bool _shouldShowProfile(List<QueryDocumentSnapshot> messages, int index) {
    if (index == messages.length - 1) return true; // 첫 메시지는 항상 표시
    final currentSender = messages[index]['senderId'];
    final previousSender = messages[index + 1]['senderId'];
    return currentSender != previousSender;
  }
}
