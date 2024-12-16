// ChatListViewModel은 채팅방 목록의 상태를 관리합니다.
// 채팅방 목록을 가져오고, 업데이트하는 로직을 담당해요.

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_seau/data/model/chat.dart';
import 'package:flutter_application_seau/data/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListState {
  // 채팅방 목록을 담을 리스트
  final List<Chat> chats;
  // // 로딩 상태를 표시
  // final bool isLoading;

  ChatListState({
    required this.chats,
    // this.isLoading = false,
  });

  // 상태 복사본을 만드는 메서드
  ChatListState copyWith({
    List<Chat>? chats,
    bool? isLoading,
  }) {
    return ChatListState(
      chats: chats ?? this.chats,
      // isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatListViewModel extends AutoDisposeNotifier<ChatListState> {
  // Repository 인스턴스 생성
  final _chatRepository = ChatRepository();
  // 스트림 구독을 관리하기 위한 변수
  StreamSubscription? _chatSubscription;

  @override
  ChatListState build() {
    // ViewModel이 생성될 때 채팅방 목록을 불러옵니다
    _loadChats();
    // 초기 상태 설정
    return ChatListState(
      chats: [],
    );
  }

  final auth = FirebaseAuth.instance;
  // 채팅방 목록을 불러오는 메서드
  Future<void> _loadChats() async {
    try {
      // 3. 하드코딩된 ID 대신 현재 로그인된 사용자의 uid를 가져와
      final currentUser = auth.currentUser;
      if (currentUser == null) {
        print('로그인된 사용자가 없습니다');
        return;
      }
      _chatSubscription =
          _chatRepository.getChats(currentUser.uid).listen((querySnapshot) {
        final chats =
            querySnapshot.docs.map((doc) => Chat.fromFirestore(doc)).toList();

        state = state.copyWith(chats: chats);
      });

      ref.onDispose(() {
        _chatSubscription?.cancel();
      });
    } catch (e) {
      print('채팅방 목록 로드 중 에러: $e');
      // 에러 발생시 로딩 상태 해제
      state = state.copyWith(isLoading: false);
    }
  }
}

// Provider 정의
final chatListViewModel =
    NotifierProvider.autoDispose<ChatListViewModel, ChatListState>(
  () => ChatListViewModel(),
);
