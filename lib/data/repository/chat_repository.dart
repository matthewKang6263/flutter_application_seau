import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';

class ChatRepository {
  final firestore = FirebaseFirestore.instance;

  // 01. 채팅방 목록 가져오기
  Stream<QuerySnapshot> getChats(String id) {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: id)
        .snapshots();
  }

  // 02. 채팅방의 모든 메시지 가져오기
  Stream<QuerySnapshot> getChatMessages(String chatId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // 03. 채팅방 찾거나 생성하기
  Future<String> createOrGetChatRoom(
      String currentUserId, String otherUserId) async {
    try {
      final existingChat = await _findExistingChat(currentUserId, otherUserId);
      if (existingChat != null) {
        return existingChat;
      }
      return await createChat([currentUserId, otherUserId]);
    } catch (e) {
      print('채팅방 생성/조회 중 에러: $e');
      throw e;
    }
  }

  // 04. 새로운 채팅방 만들기
  Future<String> createChat(List<String> participants) async {
    try {
      final chatDoc = firestore.collection('chats').doc();
      await chatDoc.set({
        'participants': participants.toSet().toList(),
        'lastMessage': '',
        'lastMessageTime': DateTime.now(),
      });
      return chatDoc.id;
    } catch (e) {
      print('채팅방 생성 중 에러 발생: $e');
      throw e;
    }
  }

  // 05. 메시지 전송하기
  Future<void> sendMessage({
    required String chatId,
    required String id,
    required String content,
  }) async {
    try {
      if (content.trim().isEmpty) {
        print('빈 메시지는 전송되지 않습니다.');
        return;
      }

      await firestore.runTransaction((transaction) async {
        final messageRef = firestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .doc();

        transaction.set(messageRef, {
          'senderId': id,
          'content': content,
          'timestamp': FieldValue.serverTimestamp(),
          'isRead': false,
        });

        final chatRef = firestore.collection('chats').doc(chatId);
        transaction.update(chatRef, {
          'lastMessage': content,
          'lastMessageTime': FieldValue.serverTimestamp(),
        });
      });
    } catch (e) {
      print('메시지 전송 중 에러 발생: $e');
      throw e;
    }
  }

  // 06. 기존 채팅방 찾기
  Future<String?> _findExistingChat(
      String currentUserId, String otherUserId) async {
    try {
      final snapshot = await firestore
          .collection('chats')
          .where('participants', arrayContainsAny: [currentUserId]).get();

      for (var doc in snapshot.docs) {
        List<String> participants = List<String>.from(doc['participants']);
        if (participants.contains(currentUserId) &&
            participants.contains(otherUserId)) {
          return doc.id;
        }
      }
      return null;
    } catch (e) {
      print('기존 채팅방 검색 중 에러: $e');
      return null;
    }
  }

  // 07. 사용자 정보 가져오기
  Future<AppUser?> getUser(String id) async {
    try {
      final doc = await firestore.collection('users').doc(id).get();
      if (doc.exists) {
        return AppUser.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('사용자 정보 로드 중 에러: $e');
      return null;
    }
  }
}
