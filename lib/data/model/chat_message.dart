import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String content;
  final String senderId;
  final DateTime timestamp;
  final bool isRead;

  ChatMessage({
    required this.content,
    required this.senderId,
    required this.timestamp,
    required this.isRead,
  });

  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      content: data["content"] ?? "",
      senderId: data['senderId'] ?? "",
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      // .toDate : Timestamp를 Datetime으로 변환함
      isRead: data['isRead'] ?? false,
    );
  }
}
//1:1이기 때문에 senderId만 있으면 자동으로 다른 id가 recieveId가 됨
