import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_seau/data/model/user.dart';

class ChatRepository {
  // Firestore 인스턴스를 가져와서 저장해둡니다
  final firestore = FirebaseFirestore.instance;

  // 특정 사용자의 모든 채팅방 목록을 실시간으로 가져오는 스트림
  Stream<QuerySnapshot> getChatRooms(String uid) {
    // chats 컬렉션에서 현재 사용자가 participants 배열에 포함된 문서들을 찾습니다
    return firestore
        .collection('chats')
        .where('participants', arrayContains: uid)
        .snapshots();
  }

  // 특정 채팅방의 모든 메시지를 실시간으로 가져오는 스트림
  Stream<QuerySnapshot> getMessages(String chatId) {
    // messages 서브컬렉션의 문서들을 시간순으로 정렬해서 가져옵니다
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // 새로운 채팅방을 생성하는 함수
  Future<String> createChatRoom(List<String> participants) async {
    try {
      // 새 채팅방 문서를 생성합니다
      final chatDoc = firestore.collection('chats').doc();

      // 채팅방 초기 데이터를 설정합니다
      await chatDoc.set({
        'participants': participants,
        'lastMessage': '',
        'lastMessageTime': DateTime.now(),
      });

      // 생성된 채팅방의 ID를 반환합니다
      return chatDoc.id;
    } catch (e) {
      print('채팅방 생성 중 에러 발생: $e');
      throw e;
    }
  }

  // 새로운 메시지를 전송하는 함수
  Future<void> sendMessage({
    required String chatId,
    required String uid,
    required String content,
  }) async {
    try {
      // 채팅방의 messages 서브컬렉션에 새 메시지를 추가합니다
      await firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': uid,
        'content': content,
        'timestamp': DateTime.now(),
        'isRead': false,
      });

      // 채팅방의 마지막 메시지 정보를 업데이트합니다
      await firestore.collection('chats').doc(chatId).update({
        'lastMessage': content,
        'lastMessageTime': DateTime.now(),
      });
    } catch (e) {
      print('메시지 전송 중 에러 발생: $e');
      throw e;
    }
  }

  // 사용자 정보 가져오기
  Future<User?> getUser(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return User.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('사용자 정보 로드 중 에러: $e');
      return null;
    }
  }
}
