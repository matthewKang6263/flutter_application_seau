import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';

class ChatRepository {
  // Firestore 인스턴스를 가져오기
  final firestore = FirebaseFirestore.instance;

  // 01_채팅방 목록 가져오기 (수정된 부분!!!!!!!!!!!!!)
  Stream<QuerySnapshot> getChats(String id) {
    return FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: id)
        // .where('lastMessage', isNotEqualTo: '') >>>> 이것때문에 계속 목록이 안불러와짐...
        .snapshots();
  }

  // 02_채팅방의 모든 메시지 가져오기 (수정된 부분!!!!!!!!!!!!!)
  Stream<QuerySnapshot> getChatMessages(String chatId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true) //시간순
        .snapshots();
  }

  // 03. 새로운 채팅방 만들기 >> 새로운 채팅방 ID를 만드는것 (아직 대화전)
  // (수정된 부분!!!!!!!!!!!!!)
  Future<String> createChat(List<String> participants) async {
    try {
      // 기존 채팅방이 있는지 확인
      final querySnapshot = await firestore
          .collection('chats')
          .where('participants', arrayContainsAny: participants)
          .get();

      // 이미 존재하는 채팅방이 있으면 해당 채팅방 ID를 반환
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      }
      // 새 채팅방 문서를 생성합니다
      final chatDoc = firestore.collection('chats').doc();

      // 채팅방 초기 데이터를 설정합니다
      await chatDoc.set({
        'participants': participants.toSet().toList(),
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

  // 04. 새로운 메시지를 전송하기 (수정된 부분!!!!!!!!!!!!!)
  Future<void> sendMessage({
    required String chatId,
    required String id,
    required String content,
  }) async {
    try {
      // 메시지가 비어있지 않은 경우에만 실행
      if (content.trim().isEmpty) {
        print('빈 메시지는 전송되지 않습니다.');
        return;
      }

      // Firebase 트랜잭션 시작 - 두 작업이 모두 성공하거나 모두 실패하도록 함
      await firestore.runTransaction((transaction) async {
        // 1. messages 서브컬렉션에 새 메시지 추가
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

        // 2. 채팅방의 마지막 메시지 정보 업데이트
        final chatRef = firestore.collection('chats').doc(chatId);
        transaction.update(chatRef, {
          'lastMessage': content,
          'lastMessageTime': FieldValue.serverTimestamp(),
        });
      });

      print('메시지 전송 성공: $content');
    } catch (e) {
      print('메시지 전송 중 에러 발생: $e');
      throw e;
    }
  }

  // 05. 사용자 정보 가져오기
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

  // 채팅방 찾거나 생성하기
  Future<String> createOrGetChatRoom(
      String currentUserId, String otherUserId) async {
    try {
      // 1. 먼저 기존 채팅방이 있는지 확인
      final existingChat = await _findExistingChat(currentUserId, otherUserId);
      if (existingChat != null) {
        return existingChat; // 있으면 기존 채팅방 ID 반환
      }

      // 2. 없으면 새로운 채팅방 생성 (기존 createChat 메서드 활용)
      return await createChat([currentUserId, otherUserId]);
    } catch (e) {
      print('채팅방 생성/조회 중 에러: $e');
      throw e;
    }
  }

// 기존 채팅방 찾기 메서드
  Future<String?> _findExistingChat(
      String currentUserId, String otherUserId) async {
    try {
      // participants 배열에 현재 사용자가 포함된 채팅방들을 가져옴
      final snapshot = await firestore
          .collection('chats')
          .where('participants', arrayContains: currentUserId)
          .get();

      // 가져온 채팅방들 중에서 상대방도 포함된 채팅방이 있는지 확인
      for (var doc in snapshot.docs) {
        List<String> participants = List<String>.from(doc['participants']);
        if (participants.contains(otherUserId)) {
          return doc.id; // 찾으면 해당 채팅방 ID 반환
        }
      }
      return null; // 없으면 null 반환
    } catch (e) {
      print('기존 채팅방 검색 중 에러: $e');
      return null;
    }
  }
}
