import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String chatId;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;
  //lastMessage, lastMessageTime 데이터는 채팅 목록에 보여주기 위해서 필요

  Chat({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory Chat.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Chat(
      // 반드시 Chat 클래스의 인스턴스를 반환
      chatId: doc.id,
      participants: List<String>.from(data["participants"]),
      lastMessage: data["lastMessage"] ?? "",
      lastMessageTime: (data["lastMessageTime"] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      // id는 문서 ID로 사용되므로 저장할 필요 없음
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
    };
  }
}
