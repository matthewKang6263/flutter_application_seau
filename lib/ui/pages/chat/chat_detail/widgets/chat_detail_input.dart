// chat_detail_input.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatDetailInput extends StatefulWidget {
  const ChatDetailInput({Key? key, required this.chatId}) : super(key: key);
  final String chatId;

  @override
  State<ChatDetailInput> createState() => _ChatDetailInputState();
}

class _ChatDetailInputState extends State<ChatDetailInput> {
  // 입력된 텍스트를 관리할 컨트롤러
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // 메모리 누수 방지를 위해 컨트롤러 해제
    _controller.dispose();
    super.dispose();
  }

  // 메시지 전송 처리 함수
  void _handleSend() async {
    final message = _controller.text.trim();
    if (message.isEmpty) return; // 빈 메시지는 전송하지 않음

    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId == null) {
        print("사용자가 로그인하지 않았습니다."); // 에러 로그 출력
        return;
      }
      // Firestore에 메시지 저장
      await FirebaseFirestore.instance
          .collection('chats') // chats 컬렉션
          .doc(widget.chatId) // 특정 채팅방 문서
          .collection('messages') // messages 서브컬렉션
          .add({
        'senderId': currentUserId,
        'content': message, // 메시지 내용
        'timestamp': FieldValue.serverTimestamp(), // 서버 타임스탬프
      });

      _controller.clear(); // 입력 필드 비우기
    } catch (e) {
      print('메시지 전송 중 오류: $e'); // 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('메시지 전송 중 오류가 발생했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        16, // 왼쪽 패딩
        12, // 위 패딩
        16, // 오른쪽 패딩
        12 + MediaQuery.of(context).padding.bottom, // 아래 패딩 + 안전영역
      ),
      child: Row(
        children: [
          // 메시지 입력 필드
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '메시지를 입력해주세요',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: InputBorder.none, // 기본 테두리 제거
                ),
                maxLines: 1, // 한 줄만 입력 가능
                textInputAction: TextInputAction.send, // 키보드의 전송 버튼 활성화
                onSubmitted: (_) => _handleSend(), // 키보드 전송 버튼 클릭시
              ),
            ),
          ),
          SizedBox(width: 4),
          // 전송 버튼
          GestureDetector(
            onTap: _handleSend,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              child: Text(
                '전송',
                style: TextStyle(
                  color: Color(0xFF0770E9),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
