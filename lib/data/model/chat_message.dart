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
      senderId: data['senderId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isRead: data['isRead'] ?? false,
    );
  }
}
