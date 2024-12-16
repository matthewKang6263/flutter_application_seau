import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;

  Chat({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory Chat.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Chat(
      id: doc.id,
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
