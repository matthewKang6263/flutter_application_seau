import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_seau/data/model/user.dart';

class ChatRepository {
  // Firestore 인스턴스를 가져오기 (기본코드)
  final firestore = FirebaseFirestore.instance;

  // Stream - 실시간 데이터 가져오기
  // 01_채팅방 목록 가져오기
  // getChats 스트림명은 기능에 맞게 내가 직접 지으면 됨. (모델명 연상이 되면 좋겠지?)
  // String uid는 getChats 기능을 만들기 위해 파이어베이스에서 가져올 데이터가 uid라는 뜻임
  Stream<QuerySnapshot> getChats(String uid) {
    // chats 컬렉션에서 현재 사용자가 participants 배열에 포함된 문서찾기
    return firestore
        .collection('chats')
        .where('participants', arrayContains: uid)
        .snapshots();
  }

  // 02_채팅방의 모든 메시지 가져오기
  Stream<QuerySnapshot> getChatMessages(String chatId) {
    // messages 서브컬렉션의 문서들을 시간순으로 정렬해서 가져옵니다
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // 03. 새로운 채팅방 만들기
  Future<String> createChat(List<String> participants) async {
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

  // 04. 새로운 메시지를 전송하기
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

  // 05. 사용자 정보 가져오기
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
